import { Repository } from 'typeorm';
import { DriverWallet } from '../../entities/driver-wallet.entity';
import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { IWalletRepository } from '@common/interfaces';

@Injectable()
export class DriverWalletRepository implements IWalletRepository<DriverWallet> {
  constructor(
    @InjectRepository(DriverWallet)
    private readonly walletRepo: Repository<DriverWallet>,
  ) {}
  create(): DriverWallet {
    return this.walletRepo.create();
  }
  async deposit(id: string, cost: number): Promise<DriverWallet> {
    console.log(id);
    const result = await this.walletRepo
      .createQueryBuilder()
      .update(DriverWallet)
      .set({ total: () => 'total + :cost' })
      .where('driverId = :id', { id, cost })
      .returning('*')
      .execute();

    const updatedWallet = result.raw[0];
    if (!updatedWallet) {
      throw new NotFoundException('Wallet not found');
    }
    return updatedWallet;
  }

  async withdraw(id: string, cost: number): Promise<DriverWallet> {
    const valid = await this.walletRepo.findOne({ where: { driverId: id } });
    if (valid.total < cost) throw new Error('driver dose not have this cost');
    const result = await this.walletRepo
      .createQueryBuilder()
      .update(DriverWallet)
      .set({ total: () => 'total - :cost' })
      .where('driverId = :id', { id, cost })
      .returning('*')
      .execute();

    const updatedWallet = result.raw[0];
    if (!updatedWallet) {
      throw new NotFoundException('Wallet not found');
    }
    return updatedWallet;
  }
}
