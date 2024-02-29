import { Repository } from 'typeorm';
import { Wallet } from '../entities/wallet.entity';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { IWalletRepository } from '../interfaces/repositories/wallet.repository.interface';

@Injectable()
export class WalletRepository implements IWalletRepository {
  constructor(
    @InjectRepository(Wallet) private readonly walletRepo: Repository<Wallet>,
  ) {}
  create(): Wallet {
    return this.walletRepo.create();
  }
}
