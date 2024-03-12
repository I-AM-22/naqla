import { Repository } from 'typeorm';
import { Wallet } from '../entities/wallet.entity';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { IWalletDriverRepository } from '../interfaces/repositories/driver-wallet.repository.interface';

@Injectable()
export class WalletDriverRepository implements IWalletDriverRepository {
  constructor(
    @InjectRepository(Wallet) private readonly walletRepo: Repository<Wallet>,
  ) {}
  create(): Wallet {
    return this.walletRepo.create();
  }
}
