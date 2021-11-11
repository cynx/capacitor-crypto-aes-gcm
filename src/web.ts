import { WebPlugin } from '@capacitor/core';

import type { CryptoPlugin } from './definitions';

export class CryptoWeb extends WebPlugin implements CryptoPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
