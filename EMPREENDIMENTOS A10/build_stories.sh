#!/bin/bash
set -e
SRC="/c/Users/joaog/Downloads/IMG-20250109-WA0014.jpg"
DY="${DY:-360}"
IMGH="${IMGH:-1180}"
FADE_TOP="${FADE_TOP:-860}"
FADE_BOT="${FADE_BOT:-1140}"
PAR="${PAR:-xMidYMid slice}"

B64=$(base64 -w0 "$SRC")
CONTENT=$(sed -n '8,44p' feed.svg)
RECTH=$(( IMGH - FADE_TOP ))

{
cat <<HEAD
<svg width="1080" height="1920" viewBox="0 0 1080 1920" fill="none" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
<defs>
<linearGradient id="fadeS" x1="540" y1="${FADE_TOP}" x2="540" y2="${FADE_BOT}" gradientUnits="userSpaceOnUse">
<stop stop-color="#0C1422" stop-opacity="0"/>
<stop offset="1" stop-color="#0C1422"/>
</linearGradient>
<radialGradient id="glowS" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(100 -95) scale(880 430)">
<stop stop-color="#08111E" stop-opacity="0.55"/>
<stop offset="1" stop-color="#08111E" stop-opacity="0"/>
</radialGradient>
<clipPath id="clipS"><rect width="1080" height="1920" fill="white"/></clipPath>
</defs>
<g clip-path="url(#clipS)">
<rect width="1080" height="1920" fill="#0C1422"/>
<image x="0" y="0" width="1080" height="${IMGH}" preserveAspectRatio="${PAR}" xlink:href="data:image/jpeg;base64,${B64}"/>
<ellipse cx="540" cy="120" rx="440" ry="215" fill="url(#glowS)"/>
<rect x="0" y="${FADE_TOP}" width="1080" height="${RECTH}" fill="url(#fadeS)"/>
<g transform="translate(0,${DY})">
HEAD
printf '%s\n' "$CONTENT"
cat <<'TAIL'
</g>
</g>
</svg>
TAIL
} > stories.svg
echo "stories.svg built ($(wc -c < stories.svg) bytes)"
