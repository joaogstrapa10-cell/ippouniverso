#!/bin/bash
set -e
cd "/c/Users/joaog/ippo-universo/EMPREENDIMENTOS A10"
B64=$(base64 -w0 hub.jpg)
FONTS=$(cat fontsCP.css)
PIN=$(cat pin.txt)
NAVY="#0C1422"; GOLD="#C9A86A"; CREAM="#F5F1E9"; INK="#11141B"
{
cat <<HEAD
<svg width="1080" height="1920" viewBox="0 0 1080 1920" fill="none" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
<defs>
<style>${FONTS}</style>
<linearGradient id="topG" x1="540" y1="0" x2="540" y2="430" gradientUnits="userSpaceOnUse">
<stop stop-color="${NAVY}" stop-opacity="0.62"/><stop offset="1" stop-color="${NAVY}" stop-opacity="0"/>
</linearGradient>
<linearGradient id="botG" x1="540" y1="860" x2="540" y2="1500" gradientUnits="userSpaceOnUse">
<stop stop-color="${NAVY}" stop-opacity="0"/>
<stop offset="0.42" stop-color="${NAVY}" stop-opacity="0.55"/>
<stop offset="0.72" stop-color="${NAVY}" stop-opacity="0.9"/>
<stop offset="1" stop-color="${NAVY}" stop-opacity="0.98"/>
</linearGradient>
</defs>

<rect width="1080" height="1920" fill="${NAVY}"/>
<image x="0" y="0" width="1080" height="1920" preserveAspectRatio="xMidYMid slice" xlink:href="data:image/jpeg;base64,${B64}"/>
<rect width="1080" height="1920" fill="${NAVY}" opacity="0.12"/>
<rect x="0" y="0" width="1080" height="430" fill="url(#topG)"/>
<rect x="0" y="860" width="1080" height="1060" fill="url(#botG)"/>

<!-- top kicker -->
<text x="540" y="150" text-anchor="middle" font-family="Poppins" font-size="18" font-weight="500" letter-spacing="6" fill="${GOLD}">PORTO BELO · SC</text>

<!-- gold rule + headline + subtitle -->
<rect x="510" y="1294" width="60" height="2" fill="${GOLD}"/>
<text x="540" y="1408" text-anchor="middle" font-family="Cormorant Garamond" font-size="124" font-weight="600" letter-spacing="1" fill="#FFFFFF">Hub 240</text>
<text x="540" y="1456" text-anchor="middle" font-family="Poppins" font-size="21" font-weight="500" letter-spacing="4" fill="${GOLD}">LANÇAMENTO · MORADIA E INVESTIMENTO</text>

<!-- specs glass bar -->
<rect x="80" y="1494" width="920" height="128" rx="20" fill="${NAVY}" fill-opacity="0.5"/>
<rect x="80.5" y="1494.5" width="919" height="127" rx="19.5" stroke="${GOLD}" stroke-opacity="0.34"/>
<line x1="310" y1="1520" x2="310" y2="1596" stroke="${GOLD}" stroke-opacity="0.28"/>
<line x1="540" y1="1520" x2="540" y2="1596" stroke="${GOLD}" stroke-opacity="0.28"/>
<line x1="770" y1="1520" x2="770" y2="1596" stroke="${GOLD}" stroke-opacity="0.28"/>
<g text-anchor="middle" font-family="Poppins" fill="#FFFFFF">
<text x="195" y="1564" font-size="30" font-weight="600">71,1<tspan font-size="18" dx="2">m²</tspan></text>
<text x="425" y="1564" font-size="30" font-weight="600">2</text>
<text x="655" y="1564" font-size="30" font-weight="600">1</text>
<text x="885" y="1564" font-size="30" font-weight="600">80<tspan font-size="18" dx="2">m²</tspan></text>
</g>
<g text-anchor="middle" font-family="Poppins" font-size="12.5" font-weight="500" letter-spacing="1.5" fill="${GOLD}">
<text x="195" y="1594">PRIVATIVOS</text>
<text x="425" y="1594">DORM · 1 SUÍTE</text>
<text x="655" y="1594">VAGA</text>
<text x="885" y="1594">ÁREA TOTAL</text>
</g>

<!-- amenities -->
<text x="540" y="1674" text-anchor="middle" font-family="Poppins" font-size="17" font-weight="400" fill="${GOLD}">Piscinas · Academia · Sala de jogos · Playground · Lavanderia compartilhada</text>

<!-- price card (cream) -->
<rect x="80" y="1710" width="300" height="110" rx="16" fill="${CREAM}"/>
<text x="104" y="1748" font-family="Poppins" font-size="13" font-weight="600" letter-spacing="2.5" fill="#6B6258">A PARTIR DE</text>
<text x="104" y="1798" font-family="Poppins" font-size="26" font-weight="500" fill="${INK}">R\$</text>
<text x="150" y="1800" font-family="Poppins" font-size="46" font-weight="700" fill="${INK}">1,09</text>
<text x="264" y="1798" font-family="Poppins" font-size="24" font-weight="400" fill="${INK}">milhão</text>

<!-- address card (glass) -->
<rect x="400" y="1710" width="600" height="110" rx="16" fill="${NAVY}" fill-opacity="0.5"/>
<rect x="400.5" y="1710.5" width="599" height="109" rx="15.5" stroke="${GOLD}" stroke-opacity="0.34"/>
<g transform="translate(8,506)">${PIN}</g>
<text x="470" y="1748" font-family="Poppins" font-size="15" font-weight="500" letter-spacing="2" fill="#FFFFFF" fill-opacity="0.62">ENDEREÇO</text>
<text x="470" y="1790" font-family="Poppins" font-size="21" font-weight="600" fill="#FFFFFF">Rua Leonor Baron, 240 · Porto Belo/SC</text>

<!-- footer -->
<text x="540" y="1878" text-anchor="middle" font-family="Poppins" font-size="19" font-weight="500"><tspan fill="#FFFFFF" fill-opacity="0.84">Entrega </tspan><tspan fill="${GOLD}" font-weight="600">Set · 2027</tspan></text>

</svg>
HEAD
} > hub_stories.svg
echo "hub_stories.svg built ($(wc -c < hub_stories.svg) bytes)"
