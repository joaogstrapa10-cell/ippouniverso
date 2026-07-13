#!/bin/bash
set -e
SRC="/c/Users/joaog/Downloads/IMG-20250109-WA0014.jpg"
B64=$(base64 -w0 "$SRC")
ICONS=$(cat icons_raw.txt)
IMGH="${IMGH:-880}"
FADE_TOP="${FADE_TOP:-540}"
FADE_BOT="${FADE_BOT:-850}"
RECTH=$(( IMGH - FADE_TOP ))

{
cat <<HEAD
<svg width="1080" height="1350" viewBox="0 0 1080 1350" fill="none" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
<defs>
<linearGradient id="fadeF" x1="540" y1="${FADE_TOP}" x2="540" y2="${FADE_BOT}" gradientUnits="userSpaceOnUse">
<stop stop-color="#0C1422" stop-opacity="0"/><stop offset="1" stop-color="#0C1422"/>
</linearGradient>
<radialGradient id="glowF" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(100 -95) scale(880 430)">
<stop stop-color="#08111E" stop-opacity="0.55"/><stop offset="1" stop-color="#08111E" stop-opacity="0"/>
</radialGradient>
<clipPath id="clipF"><rect width="1080" height="1350"/></clipPath>
</defs>
<g clip-path="url(#clipF)">

<!-- BACKGROUND -->
<rect width="1080" height="1350" fill="#0C1422"/>
<image x="0" y="0" width="1080" height="${IMGH}" preserveAspectRatio="xMidYMid slice" xlink:href="data:image/jpeg;base64,${B64}"/>
<ellipse cx="540" cy="120" rx="440" ry="215" fill="url(#glowF)"/>
<rect x="0" y="${FADE_TOP}" width="1080" height="${RECTH}" fill="url(#fadeF)"/>

<!-- HEADLINE -->
<text font-family="Cormorant Garamond" x="73" y="962" font-size="106" font-weight="500" fill="#FFFFFF" letter-spacing="1">Sunstar Tower</text>
<text font-family="Poppins" x="80" y="1002" font-size="21" font-weight="500" fill="#C9A86A" letter-spacing="5">LANÇAMENTO · ITAPEMA-SC</text>

<!-- SPEC CARDS -->
<g>
<rect x="76"  y="1028" width="172" height="98" rx="16" fill="#101A2B"/>
<rect x="76.5"  y="1028.5" width="171" height="97" rx="15.5" stroke="#C9A86A" stroke-opacity="0.34"/>
<rect x="288" y="1028" width="175" height="98" rx="16" fill="#101A2B"/>
<rect x="288.5" y="1028.5" width="174" height="97" rx="15.5" stroke="#C9A86A" stroke-opacity="0.34"/>
<rect x="502" y="1028" width="172" height="98" rx="16" fill="#101A2B"/>
<rect x="502.5" y="1028.5" width="171" height="97" rx="15.5" stroke="#C9A86A" stroke-opacity="0.34"/>
<rect x="714" y="1028" width="172" height="98" rx="16" fill="#101A2B"/>
<rect x="714.5" y="1028.5" width="171" height="97" rx="15.5" stroke="#C9A86A" stroke-opacity="0.34"/>
</g>
<g id="icons">
${ICONS}
</g>
<g font-family="Poppins" fill="#FFFFFF">
<text font-family="Poppins" x="98"  y="1090" font-size="26" font-weight="600">4 Suítes</text>
<text font-family="Poppins" x="310" y="1090" font-size="26" font-weight="600">206 m²</text>
<text font-family="Poppins" x="524" y="1090" font-size="26" font-weight="600">1 / andar</text>
<text font-family="Poppins" x="736" y="1090" font-size="26" font-weight="600">3 vagas</text>
</g>
<g font-family="Poppins" fill="#FFFFFF" fill-opacity="0.66" font-size="13.5" font-weight="400">
<text font-family="Poppins" x="98"  y="1110">4 banheiros</text>
<text font-family="Poppins" x="310" y="1110">privativos · 237 totais</text>
<text font-family="Poppins" x="524" y="1110">privacidade total</text>
<text font-family="Poppins" x="736" y="1110">de garagem</text>
</g>

<!-- AMENITIES TAG -->
<text font-family="Poppins" x="80" y="1167" font-size="19" font-weight="400" fill="#C9A86A" letter-spacing="0.4">Rooftop + Bar  ·  3 Piscinas  ·  Academia  ·  Lounge Gourmet  ·  Segurança 24h</text>

<!-- PRICE CARD -->
<rect x="76" y="1198" width="300" height="110" rx="18" fill="#F5F1E9"/>
<text font-family="Poppins" x="98" y="1231" font-size="15" font-weight="500" fill="#6B6258" letter-spacing="2.5">A PARTIR DE</text>
<text font-family="Poppins" x="96" y="1288" font-size="29" font-weight="500" fill="#11141B">R$</text>
<text font-family="Poppins" x="138" y="1290" font-size="58" font-weight="700" fill="#11141B" letter-spacing="-1">4,37</text>
<text font-family="Poppins" x="278" y="1288" font-size="28" font-weight="400" fill="#11141B">milhões</text>

<!-- ADDRESS CARD -->
<rect x="392" y="1198" width="376" height="110" rx="18" fill="#161C2A"/>
<rect x="392.5" y="1198.5" width="375" height="109" rx="17.5" stroke="#C9A86A" stroke-opacity="0.34"/>
<text font-family="Poppins" x="452" y="1232" font-size="16" font-weight="500" fill="#FFFFFF" fill-opacity="0.62" letter-spacing="2.5">ENDEREÇO</text>
<text font-family="Poppins" x="416" y="1278" font-size="26" font-weight="600" fill="#FFFFFF">Av. Nereu Ramos, 385 · Centro</text>

<!-- FOOTER RIGHT -->
<text font-family="Poppins" x="836" y="1230" font-size="16" font-weight="500" fill="#FFFFFF" fill-opacity="0.6" letter-spacing="1.2">ARQUITETURA ·</text>
<text font-family="Poppins" x="836" y="1250" font-size="16" font-weight="500" fill="#FFFFFF" fill-opacity="0.6" letter-spacing="1.2">VICTOR BOMTEMPO</text>
<text font-family="Poppins" x="836" y="1288" font-size="24" font-weight="500"><tspan fill="#FFFFFF" fill-opacity="0.84">Entrega </tspan><tspan fill="#C9A86A" font-weight="600">Out · 2026</tspan></text>

</g>
</svg>
HEAD
} > feed_editable.svg
echo "feed_editable.svg built ($(wc -c < feed_editable.svg) bytes)"
