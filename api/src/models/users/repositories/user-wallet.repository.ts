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
  async check(id: string, cost: number): Promise<boolean> {
    const user = await this.walletRepo.findOne({ where: { userId: id } });
    return user.available() < cost ? false : true;
  }
  async updatePending(id: string, cost: number): Promise<UserWallet> {
    const result = await this.walletRepo
      .createQueryBuilder()
      .update(UserWallet)
      .set({ pending: () => 'pending + :cost' })
      .where('userId = :id', { id, cost })
      .returning('*')
      .execute();
    const updatedWallet = result.raw[0];
    if (!updatedWallet) {
      throw new Error('Wallet not found');
    }
    return updatedWallet;
  }
  async restPending(id: string): Promise<UserWallet> {
    const result = await this.walletRepo
      .createQueryBuilder()
      .update(UserWallet)
      .set({ pending: 0 })
      .where('userId = :id', { id })
      .returning('*')
      .execute();
    const updatedWallet = result.raw[0];
    if (!updatedWallet) {
      throw new Error('Wallet not found');
    }
    return updatedWallet;
  }

  //ايداع
  async deposit(id: string, cost: number): Promise<UserWallet> {
    const result = await this.walletRepo
      .createQueryBuilder()
      .update(UserWallet)
      .set({ total: () => 'total + :cost' })
      .where('userId = :id', { id, cost })
      .returning('*')
      .execute();
    const updatedWallet = result.raw[0];
    if (!updatedWallet) {
      throw new Error('Wallet not found');
    }
    return updatedWallet;
  }

  //سحب من اجل اعطاء سائق
  async withdrawForDriver(id: string, cost: number): Promise<UserWallet> {
    const result = await this.walletRepo
      .createQueryBuilder()
      .update(UserWallet)
      .set({ total: () => 'total - :cost', pending: () => 'pending - :cost' })
      .where('userId = :id', { id, cost })
      .returning('*')
      .execute();
    const updatedWallet = result.raw[0];
    if (!updatedWallet) {
      throw new Error('Wallet not found');
    }
    return updatedWallet;
  }

  async withdraw(id: string, cost: number): Promise<UserWallet> {
    const valid = await this.walletRepo.findOne({ where: { userId: id } });
    if (valid.total < cost) throw new Error('user dose not have this cost');
    const result = await this.walletRepo
      .createQueryBuilder()
      .update(UserWallet)
      .set({ total: () => 'total - :cost' })
      .where('userId = :id', { id, cost })
      .returning('*')
      .execute();
    const updatedWallet = result.raw[0];
    if (!updatedWallet) {
      throw new Error('Wallet not found');
    }
    return updatedWallet;
  }
}
