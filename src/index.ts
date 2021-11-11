import { registerPlugin } from '@capacitor/core';

import type { CryptoPlugin } from './definitions';
// test comment
const Crypto = registerPlugin<CryptoPlugin>('Crypto', {
  web: () => import('./web').then(m => new m.CryptoWeb()),
});

export * from './definitions';
export { Crypto };
