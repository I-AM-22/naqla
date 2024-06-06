import { Repository } from 'typeorm';
import { UserWallet } from '../entities/user-wallet.entity';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { IWalletRepository } from '@common/interfaces';

@Injectable()
export class UserWalletRepository implements IWalletRepository<UserWallet> {
  constructor(
    @InjectRepository(UserWallet)
    private readonly walletRepo: Repository<UserWallet>,
  ) {}
  create(): UserWallet {
    return this.walletRepo.create();
  }
}
