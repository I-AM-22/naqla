import { Wallet } from '../../entities/wallet.entity';

export interface IWalletRepository {
  create(): Wallet;
}
