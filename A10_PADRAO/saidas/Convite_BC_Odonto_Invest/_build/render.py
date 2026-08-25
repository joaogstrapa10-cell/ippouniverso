#!/usr/bin/env python3
"""
Render do convite (HTML -> PDF A4 paisagem) com Playwright + Chromium.

O Chromium desta máquina não tem saída de rede, então as requisições para
fonts.googleapis.com / fonts.gstatic.com são interceptadas e respondidas com o
cache local em _build/fonts (baixado antes via curl). O HTML permanece com o
<link> normal do Google Fonts, funcionando em qualquer máquina com internet.
"""
import pathlib
import re
import sys

from playwright.sync_api import sync_playwright

HERE = pathlib.Path(__file__).resolve().parent
OUT = HERE.parent
FONTS = HERE / "fonts"
CHROME = "/opt/pw-browsers/chromium"

SRC = OUT / "CONVITE_BC_ODONTO_INVEST_v3.html"

# (classe de paleta, arquivo de saida). None = usa a classe que estiver no <body>
# do HTML — este e o arquivo canonico da entrega.
VARIANTS = [
    ("pal-a", OUT / "CONVITE_BC_ODONTO_INVEST_v3_A_escura.pdf"),
    ("pal-b", OUT / "CONVITE_BC_ODONTO_INVEST_v3_B_creme.pdf"),
    (None,    OUT / "CONVITE_BC_ODONTO_INVEST_v3.pdf"),
]

GF_CSS = (FONTS / "gf.css").read_text(encoding="utf-8")


def handle_googleapis(route):
    route.fulfill(status=200, content_type="text/css; charset=utf-8", body=GF_CSS)


def handle_gstatic(route):
    name = route.request.url.rsplit("/", 1)[-1].split("?")[0]
    path = FONTS / name
    if not path.exists():
        print(f"  ! fonte não cacheada: {name}", file=sys.stderr)
        return route.abort()
    route.fulfill(status=200, content_type="font/woff2", body=path.read_bytes())


def main():
    faces = len(re.findall(r"@font-face", GF_CSS))
    print(f"cache de fontes: {faces} @font-face, "
          f"{len(list(FONTS.glob('*.woff2')))} arquivos woff2")

    with sync_playwright() as p:
        browser = p.chromium.launch(executable_path=CHROME, args=["--no-sandbox"])
        page = browser.new_page(viewport={"width": 1123, "height": 794})
        page.route("https://fonts.googleapis.com/**", handle_googleapis)
        page.route("https://fonts.gstatic.com/**", handle_gstatic)

        for cls, pdf_path in VARIANTS:
            print(f"\n== {cls} -> {pdf_path.name}")
            page.goto(SRC.as_uri(), wait_until="networkidle")
            if cls:
                page.evaluate("c => { document.body.className = c; }", cls)
            else:
                print("   paleta do arquivo:",
                      page.evaluate("() => document.body.className"))

            page.wait_for_load_state("networkidle")
            page.evaluate("() => document.fonts.ready")
            page.wait_for_timeout(1200)

            diag = page.evaluate(
                """() => {
                  const px = 297 * 96 / 25.4;
                  const probe = (fam) => {
                    const s = document.createElement('span');
                    s.textContent = 'Balneário Camboriú 0123';
                    s.style.cssText =
                      'position:absolute;visibility:hidden;font-size:80px;font-family:' + fam;
                    document.body.appendChild(s);
                    const w = s.getBoundingClientRect().width;
                    s.remove();
                    return Math.round(w * 100) / 100;
                  };
                  return {
                    scrollW: document.documentElement.scrollWidth,
                    bodyW: document.body.scrollWidth,
                    expectedW: Math.round(px * 100) / 100,
                    pages: document.querySelectorAll('.page').length,
                    cormorantLoaded: document.fonts.check('500 63px "Cormorant Garamond"'),
                    interLoaded: document.fonts.check('400 10px "Inter"'),
                    wCormorant: probe('"Cormorant Garamond"'),
                    wSerifFallback: probe('serif'),
                    wInter: probe('"Inter"'),
                    wSansFallback: probe('sans-serif'),
                    overflow: [...document.querySelectorAll('.page')].map(
                      (el, i) => [i + 1, el.scrollWidth, el.scrollHeight])
                  };
                }"""
            )
            for k, v in diag.items():
                print(f"   {k}: {v}")

            if diag["scrollW"] > diag["expectedW"] + 1:
                print("   !! ALERTA: conteúdo mais largo que a página "
                      "(risco de shrink-to-fit)", file=sys.stderr)
            if not (diag["cormorantLoaded"] and diag["interLoaded"]):
                print("   !! ALERTA: fonte não carregada", file=sys.stderr)
            if diag["wCormorant"] == diag["wSerifFallback"]:
                print("   !! ALERTA: Cormorant caiu no fallback serif", file=sys.stderr)
            if diag["wInter"] == diag["wSansFallback"]:
                print("   !! ALERTA: Inter caiu no fallback sans-serif", file=sys.stderr)

            page.pdf(path=str(pdf_path), prefer_css_page_size=True,
                     print_background=True)
            print(f"   ok -> {pdf_path}")

        browser.close()


if __name__ == "__main__":
    main()
