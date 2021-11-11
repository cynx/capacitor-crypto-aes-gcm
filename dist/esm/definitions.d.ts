export interface CryptoPlugin {
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
}
