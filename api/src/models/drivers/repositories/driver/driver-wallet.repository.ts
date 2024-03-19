import { Repository } from 'typeorm';
import { DriverWallet } from '../../entities/driver-wallet.entity';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { IWalletRepository } from '../../../../common/interfaces';

@Injectable()
export class DriverWalletRepository implements IWalletRepository<DriverWallet> {
  constructor(
    @InjectRepository(DriverWallet)
    private readonly walletRepo: Repository<DriverWallet>,
  ) {}
  create(): DriverWallet {
    return this.walletRepo.create();
  }
}
