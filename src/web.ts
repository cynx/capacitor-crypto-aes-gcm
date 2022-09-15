import { WebPlugin } from '@capacitor/core';

import type { CryptoPlugin } from './definitions';

export class CryptoWeb extends WebPlugin implements CryptoPlugin {

  async encrypt(options: { text: string, base64Encoded: string }): Promise<{ encrypted: string }> {
    console.log('Not implemented', options);
    return {encrypted: ''};
  }

  async decrypt(options: { text: string, base64Encoded: string }): Promise<{ decrypted: string }> {
    console.log('Not implemented', options);
    return {decrypted: ''};
  }

  async generateSymmetricKey(): Promise<string> {
    console.log('Not Implemented')
    return 'Not Implemented';
  }
  
  async generateIV(): Promise<string> {
    console.log('Not Implemented')
    return 'Not Implemented';
  }
}
