import { Wallet } from '../../entities/wallet.entity';

export interface IWalletDriverRepository {
  create(): Wallet;
}
