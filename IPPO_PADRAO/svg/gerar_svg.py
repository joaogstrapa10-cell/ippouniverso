import json, re, math, pathlib, unicodedata

FONT = {"Main": ("Manrope", "Manrope, 'Helvetica Neue', Arial, sans-serif"),
        "V2_TrilhaSpec": ("Schibsted Grotesk", "'Schibsted Grotesk', 'Helvetica Neue', Arial, sans-serif"),
        "V5_AssinaturaTeal": ("Instrument Sans", "'Instrument Sans', 'Helvetica Neue', Arial, sans-serif")}
TITULO = {"Main": "IPPO · V1 Herói Docente · Feed 1080x1350",
          "V2_TrilhaSpec": "IPPO · V2 Trilha de Especificação · Feed 1080x1350",
          "V5_AssinaturaTeal": "IPPO · V5 Assinatura Teal · Feed 1080x1350"}

def esc(s):
    return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")

def num(v):
    f = float(v)
    return str(int(f)) if f == int(f) else f"{f:.2f}".rstrip("0").rstrip(".")

def stops(css):
    out = []
    for m in re.finditer(r'rgba?\(\s*([\d.]+)\s*,\s*([\d.]+)\s*,\s*([\d.]+)\s*(?:,\s*([\d.]+)\s*)?\)\s*([\d.]+)%', css):
        r, g, b, a, off = m.groups()
        out.append((f"rgb({int(float(r))},{int(float(g))},{int(float(b))})",
                    float(a) if a is not None else 1.0, float(off) / 100))
    if out and out[-1][2] < 1.0:
        out.append((out[-1][0], out[-1][1], 1.0))
    return out

def grad_def(gid, node):
    st = stops(node["css"])
    body = "".join(f'<stop offset="{num(o)}" stop-color="{c}" stop-opacity="{num(a)}"/>' for c, a, o in st)
    if node["css"].startswith("radial"):
        return f'<radialGradient id="{gid}" cx="0.5" cy="0.5" r="0.5">{body}</radialGradient>'
    return f'<linearGradient id="{gid}" x1="0" y1="0" x2="0" y2="1">{body}</linearGradient>'

def rid(txt):
    s = unicodedata.normalize("NFKD", txt).encode("ascii", "ignore").decode().lower()
    s = re.sub(r"[^a-z0-9]+", "_", s).strip("_")
    return s[:34] or "texto"

def classify(stem, nodes):
    """Nomeia cada no para virar nome de camada legivel no Figma."""
    ids, ngrad, nicone, nspec = [], 0, 0, 0
    big = max((n["size"] for n in nodes if n["kind"] == "text"), default=0)
    for n in nodes:
        k = n["kind"]
        if k == "svg":
            if n["w"] >= 800: ids.append("FOTO_corpo_docente")
            elif n["viewBox"] == "0 0 46 54": ids.append("marca_escudo")
            else:
                nicone += 1; ids.append(f"icone_{nicone}")
        elif k == "gradbox":
            ngrad += 1
            ids.append("halo_teal" if n["css"].startswith("radial")
                       else ("veu_navy" if ngrad == 1 and stem != "V5_AssinaturaTeal" else "scrim_base"))
        elif k in ("rect", "border"):
            ids.append("fio_" + (n.get("side") or "horizontal"))
        elif k == "text":
            t = n["lines"][0]["txt"].strip()
            if t in ("instituto", "IPPO"): ids.append("marca_" + rid(t))
            elif n["size"] == big: ids.append("manchete")
            elif n["fill"] == "rgb(2, 211, 180)" and n["size"] <= 22: ids.append("eyebrow")
            elif t.startswith("Dalton"): ids.append("docentes")
            elif n["size"] >= 26: ids.append("linha_apoio")
            else:
                nspec += 1; ids.append(f"spec_{nspec}_{rid(t)}")
        else:
            ids.append("no")
    return ids

for stem, (famname, famstack) in FONT.items():
    j = json.loads(pathlib.Path(f"/tmp/prev/{stem}.json").read_text())
    nodes, W, H = j["nodes"], j["w"], j["h"]
    ids = classify(stem, nodes)
    face = pathlib.Path(f"/tmp/fonts/{famname.replace(' ', '')}.css").read_text()
    big = max(n["size"] for n in nodes if n["kind"] == "text")

    defs, body, gi = [face], [], 0
    for n, nid in zip(nodes, ids):
        k = n["kind"]
        if k == "svg":
            sx = n["w"] / float(n["viewBox"].split()[2])
            sy = n["h"] / float(n["viewBox"].split()[3])
            tr = f'translate({num(n["x"])} {num(n["y"])})'
            if abs(sx - 1) > 1e-6 or abs(sy - 1) > 1e-6:
                tr += f' scale({num(round(sx, 5))} {num(round(sy, 5))})'
            pres = (" " + n["pres"]) if n.get("pres") else ""
            cl = n.get("clip"); clat = ""
            if cl and not (cl["x"] <= 0 and cl["y"] <= 0 and cl["w"] >= W and cl["h"] >= H):
                gi += 1; cid = f"clip{gi}"
                defs.append(f'<clipPath id="{cid}"><rect x="{num(cl["x"])}" y="{num(cl["y"])}" '
                            f'width="{num(cl["w"])}" height="{num(cl["h"])}"/></clipPath>')
                clat = f' clip-path="url(#{cid})"'
            body.append(f'<g id="{nid}"{clat} transform="{tr}"{pres}>{n["inner"].strip()}</g>')
        elif k == "gradbox":
            gi += 1; gid = f"grad{gi}"
            defs.append(grad_def(gid, n))
            body.append(f'<rect id="{nid}" x="{num(n["x"])}" y="{num(n["y"])}" '
                        f'width="{num(n["w"])}" height="{num(n["h"])}" fill="url(#{gid})"/>')
        elif k == "rect":
            body.append(f'<rect id="{nid}" x="{num(n["x"])}" y="{num(n["y"])}" '
                        f'width="{num(n["w"])}" height="{num(n["h"])}" fill="{n["fill"]}"/>')
        elif k == "border":
            s, x, y, w, h, t = n["side"], n["x"], n["y"], n["w"], n["h"], n["wid"]
            rc = {"top": (x, y, w, t), "bottom": (x, y + h - t, w, t),
                  "left": (x, y, t, h), "right": (x + w - t, y, t, h)}[s]
            body.append(f'<rect id="{nid}" x="{num(rc[0])}" y="{num(rc[1])}" '
                        f'width="{num(rc[2])}" height="{num(rc[3])}" fill="{n["fill"]}"/>')
        elif k == "text":
            fill = n["fill"]
            # V5: a palavra-chave carrega a assinatura cromatica em degrade
            if stem == "V5_AssinaturaTeal" and n["size"] == big:
                bx = n["box"]; ang = math.radians(96)
                cx0, cy0 = bx["x"] + bx["w"] / 2, bx["y"] + bx["h"] / 2
                ux, uy = math.sin(ang), -math.cos(ang)
                gl = abs(bx["w"] * math.sin(ang)) + abs(bx["h"] * math.cos(ang))
                x0, y0 = cx0 - gl / 2 * ux, cy0 - gl / 2 * uy
                x1, y1 = cx0 + gl / 2 * ux, cy0 + gl / 2 * uy
                defs.append(f'<linearGradient id="tipo_degrade" gradientUnits="userSpaceOnUse" '
                            f'x1="{num(x0)}" y1="{num(y0)}" x2="{num(x1)}" y2="{num(y1)}">'
                            f'<stop offset="0.06" stop-color="#F7FAFB"/>'
                            f'<stop offset="0.52" stop-color="#7BEFDD"/>'
                            f'<stop offset="0.96" stop-color="#02D3B4"/></linearGradient>')
                fill = "url(#tipo_degrade)"
            ls = f' letter-spacing="{num(n["ls"])}"' if abs(n["ls"]) > 0.01 else ""
            tt = n.get("tt", "none")
            def cast(t):
                return t.upper() if tt == "uppercase" else (t.lower() if tt == "lowercase" else t)
            spans = "".join(f'<tspan x="{num(l["x"])}" y="{num(l["base"])}">{esc(cast(l["txt"].rstrip()))}</tspan>'
                            for l in n["lines"])
            body.append(f'<text id="{nid}" font-size="{num(n["size"])}" font-weight="{n["weight"]}"'
                        f'{ls} fill="{fill}" xml:space="preserve">{spans}</text>')

    svg = (f'<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}" '
           f'font-family="{esc(famstack)}">\n'
           f'<title>{esc(TITULO[stem])}</title>\n'
           f'<desc>Instituto IPPO — navy #061824 + cyan-teal #02D3B4. Fonte {famname} embutida. '
           f'Substituir o grupo FOTO_corpo_docente pela foto real (recortar para preencher, nunca esticar).</desc>\n'
           f'<defs>\n<style type="text/css"><![CDATA[\n{defs[0]}\n]]></style>\n'
           + "\n".join(defs[1:]) + f'\n</defs>\n'
           f'<rect width="{W}" height="{H}" fill="#061824"/>\n' + "\n".join(body) + '\n</svg>\n')

    nome = {"Main": "IPPO_V1_HeroiDocente_Feed_1080x1350.svg",
            "V2_TrilhaSpec": "IPPO_V2_TrilhaSpec_Feed_1080x1350.svg",
            "V5_AssinaturaTeal": "IPPO_V5_AssinaturaTeal_Feed_1080x1350.svg"}[stem]
    pathlib.Path(nome).write_text(svg)
    print(f"{nome}: {len(svg)} bytes, {len(body)} elementos")
