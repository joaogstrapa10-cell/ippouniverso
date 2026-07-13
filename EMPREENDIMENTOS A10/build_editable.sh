#!/bin/bash
set -e
SRC="/c/Users/joaog/Downloads/IMG-20250109-WA0014.jpg"
B64=$(base64 -w0 "$SRC")
ICONS=$(cat icons_raw.txt)

{
cat <<HEAD
<svg width="1080" height="1920" viewBox="0 0 1080 1920" fill="none" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
<defs>
<style>
@import url('https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600&amp;family=Poppins:wght@400;500;600;700&amp;display=swap');
.serif{font-family:'Cormorant Garamond',serif;}
.sans{font-family:'Poppins',sans-serif;}
</style>
<linearGradient id="fadeS" x1="540" y1="860" x2="540" y2="1140" gradientUnits="userSpaceOnUse">
<stop stop-color="#0C1422" stop-opacity="0"/><stop offset="1" stop-color="#0C1422"/>
</linearGradient>
<radialGradient id="glowS" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(100 -95) scale(880 430)">
<stop stop-color="#08111E" stop-opacity="0.55"/><stop offset="1" stop-color="#08111E" stop-opacity="0"/>
</radialGradient>
<clipPath id="clipS"><rect width="1080" height="1920"/></clipPath>
</defs>
<g clip-path="url(#clipS)">

<!-- BACKGROUND -->
<rect width="1080" height="1920" fill="#0C1422"/>
<image x="0" y="0" width="1080" height="1180" preserveAspectRatio="xMidYMid slice" xlink:href="data:image/jpeg;base64,${B64}"/>
<ellipse cx="540" cy="120" rx="440" ry="215" fill="url(#glowS)"/>
<rect x="0" y="860" width="1080" height="320" fill="url(#fadeS)"/>

<!-- HEADLINE -->
<text font-family="Cormorant Garamond" x="73" y="1322" font-size="106" font-weight="500" fill="#FFFFFF" letter-spacing="1">Sunstar Tower</text>
<text font-family="Poppins" x="80" y="1362" font-size="21" font-weight="500" fill="#C9A86A" letter-spacing="5">LANÇAMENTO · ITAPEMA-SC</text>

<!-- SPEC CARDS -->
<g>
<rect x="76"  y="1388" width="172" height="98" rx="16" fill="#101A2B"/>
<rect x="76.5"  y="1388.5" width="171" height="97" rx="15.5" stroke="#C9A86A" stroke-opacity="0.34"/>
<rect x="288" y="1388" width="175" height="98" rx="16" fill="#101A2B"/>
<rect x="288.5" y="1388.5" width="174" height="97" rx="15.5" stroke="#C9A86A" stroke-opacity="0.34"/>
<rect x="502" y="1388" width="172" height="98" rx="16" fill="#101A2B"/>
<rect x="502.5" y="1388.5" width="171" height="97" rx="15.5" stroke="#C9A86A" stroke-opacity="0.34"/>
<rect x="714" y="1388" width="172" height="98" rx="16" fill="#101A2B"/>
<rect x="714.5" y="1388.5" width="171" height="97" rx="15.5" stroke="#C9A86A" stroke-opacity="0.34"/>
</g>
<g id="icons" transform="translate(0,360)">
${ICONS}
</g>
<g font-family="Poppins" fill="#FFFFFF">
<text x="98"  y="1450" font-size="26" font-weight="600">4 Suítes</text>
<text x="310" y="1450" font-size="26" font-weight="600">206 m²</text>
<text x="524" y="1450" font-size="26" font-weight="600">1 / andar</text>
<text x="736" y="1450" font-size="26" font-weight="600">3 vagas</text>
</g>
<g font-family="Poppins" fill="#FFFFFF" fill-opacity="0.66" font-size="13.5" font-weight="400">
<text x="98"  y="1470">4 banheiros</text>
<text x="310" y="1470">privativos · 237 totais</text>
<text x="524" y="1470">privacidade total</text>
<text x="736" y="1470">de garagem</text>
</g>

<!-- AMENITIES TAG -->
<text font-family="Poppins" x="80" y="1527" font-size="19" font-weight="400" fill="#C9A86A" letter-spacing="0.4">Rooftop + Bar  ·  3 Piscinas  ·  Academia  ·  Lounge Gourmet  ·  Segurança 24h</text>

<!-- PRICE CARD -->
<rect x="76" y="1558" width="300" height="110" rx="18" fill="#F5F1E9"/>
<text font-family="Poppins" x="98" y="1591" font-size="15" font-weight="500" fill="#6B6258" letter-spacing="2.5">A PARTIR DE</text>
<text font-family="Poppins" x="96" y="1648" font-size="29" font-weight="500" fill="#11141B">R$</text>
<text font-family="Poppins" x="138" y="1650" font-size="58" font-weight="700" fill="#11141B" letter-spacing="-1">4,37</text>
<text font-family="Poppins" x="278" y="1648" font-size="28" font-weight="400" fill="#11141B">milhões</text>

<!-- ADDRESS CARD -->
<rect x="392" y="1558" width="376" height="110" rx="18" fill="#161C2A"/>
<rect x="392.5" y="1558.5" width="375" height="109" rx="17.5" stroke="#C9A86A" stroke-opacity="0.34"/>
<text font-family="Poppins" x="452" y="1592" font-size="16" font-weight="500" fill="#FFFFFF" fill-opacity="0.62" letter-spacing="2.5">ENDEREÇO</text>
<text font-family="Poppins" x="416" y="1638" font-size="26" font-weight="600" fill="#FFFFFF">Av. Nereu Ramos, 385 · Centro</text>

<!-- FOOTER RIGHT -->
<text font-family="Poppins" x="836" y="1590" font-size="16" font-weight="500" fill="#FFFFFF" fill-opacity="0.6" letter-spacing="1.2">ARQUITETURA ·</text>
<text font-family="Poppins" x="836" y="1610" font-size="16" font-weight="500" fill="#FFFFFF" fill-opacity="0.6" letter-spacing="1.2">VICTOR BOMTEMPO</text>
<text font-family="Poppins" x="836" y="1648" font-size="24" font-weight="500"><tspan fill="#FFFFFF" fill-opacity="0.84">Entrega </tspan><tspan fill="#C9A86A" font-weight="600">Out · 2026</tspan></text>

</g>
</svg>
HEAD
} > editable.svg
echo "editable.svg built ($(wc -c < editable.svg) bytes)"
