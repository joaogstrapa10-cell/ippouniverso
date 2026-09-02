/* Renderiza cada SVG em PNG 1:1 e monta o PDF do deck, com as fontes reais
   embutidas (nenhuma rede necessária). Uso: node render.cjs            */
const { chromium } = require('playwright');
const fs = require('fs'), path = require('path');

const AQUI = __dirname;
const PECA = path.join(AQUI, '..');
const FONTES = fs.readFileSync(path.join(PECA, '../Apresentacao_Portfolio_3D/_build/fonts_embedded.css'), 'utf8');
const CSS = FONTES + '\nhtml,body{margin:0;background:#0B1624}svg{display:block}';
const CHROME = process.env.CHROME || '/opt/pw-browsers/chromium-1194/chrome-linux/chrome';

const semXml = f => fs.readFileSync(f, 'utf8').replace(/<\?xml[^>]*\?>/, '');

(async () => {
  const deck = path.join(PECA, 'apresentacao');
  const alvos = [...fs.readdirSync(deck).filter(f => f.endsWith('.svg')).sort().map(f => path.join(deck, f)),
                 ...fs.readdirSync(PECA).filter(f => f.endsWith('.svg')).map(f => path.join(PECA, f))];
  const b = await chromium.launch({ executablePath: CHROME });
  for (const svg of alvos) {
    fs.writeFileSync('/tmp/_peca.html', '<!doctype html><meta charset="utf-8"><style>' + CSS + '</style>' + semXml(svg));
    const p = await b.newPage({ viewport: { width: 1920, height: 1080 } });
    await p.goto('file:///tmp/_peca.html', { waitUntil: 'domcontentloaded', timeout: 120000 });
    await p.evaluate(() => document.fonts.ready);
    await p.waitForTimeout(400);
    const fora = await p.evaluate(() => {
      const svg = document.querySelector('svg');
      const w = +svg.getAttribute('width'), h = +svg.getAttribute('height');
      const m = w > 1200 ? 44 : 28;
      return [...svg.querySelectorAll('text')].map(t => {
        const b = t.getBBox();
        return { t: t.textContent.slice(0, 26), x1: Math.round(b.x), x2: Math.round(b.x + b.width), y2: Math.round(b.y + b.height) };
      }).filter(b => b.x1 < m || b.x2 > w - m || b.y2 > h - m);
    });
    console.log(path.basename(svg), fora.length ? JSON.stringify(fora) : 'ok');
    await p.locator('svg').screenshot({ path: svg.replace(/\.svg$/, '_preview.png') });
    await p.close();
  }
  // PDF do deck: um slide por página, 1920×1080
  const slides = fs.readdirSync(deck).filter(f => f.endsWith('.svg')).sort()
    .map(f => '<div class="slide">' + semXml(path.join(deck, f)) + '</div>').join('');
  fs.writeFileSync('/tmp/_deck.html', '<!doctype html><meta charset="utf-8"><style>' + CSS +
    '\n@page{size:1920px 1080px;margin:0}.slide{width:1920px;height:1080px;page-break-after:always;overflow:hidden}' +
    '.slide:last-child{page-break-after:auto}</style>' + slides);
  const p = await b.newPage({ viewport: { width: 1920, height: 1080 } });
  await p.goto('file:///tmp/_deck.html', { waitUntil: 'domcontentloaded', timeout: 120000 });
  await p.evaluate(() => document.fonts.ready);
  await p.waitForTimeout(800);
  await p.pdf({ path: path.join(deck, 'A10_Apresentacao_Institucional.pdf'), width: '1920px', height: '1080px', printBackground: true });
  await b.close();
  console.log('pdf pronto');
})();
