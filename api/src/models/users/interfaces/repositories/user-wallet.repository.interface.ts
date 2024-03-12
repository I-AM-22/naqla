import { Wallet } from '../../entities/wallet.entity';

export interface IWalletUserRepository {
  create(): Wallet;
}
