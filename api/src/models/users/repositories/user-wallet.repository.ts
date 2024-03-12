import { Repository } from 'typeorm';
import { Wallet } from '../entities/wallet.entity';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { IWalletUserRepository } from '../interfaces/repositories/user-wallet.repository.interface';

@Injectable()
export class WalletUserRepository implements IWalletUserRepository {
  constructor(
    @InjectRepository(Wallet) private readonly walletRepo: Repository<Wallet>,
  ) {}
  create(): Wallet {
    return this.walletRepo.create();
  }
}
