import { WebPlugin } from '@capacitor/core';
import type { CryptoPlugin } from './definitions';
export declare class CryptoWeb extends WebPlugin implements CryptoPlugin {
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
}
