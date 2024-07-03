import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { CreateAdvantageDto, UpdateAdvantageDto } from '../dto';
import { Advantage } from '../entities/advantage.entity';
import { IAdvantageRepository } from '../interfaces/repositories/advantage.repository.interface';

@Injectable()
export class AdvantageRepository implements IAdvantageRepository {
  constructor(
    @InjectRepository(Advantage)
    private readonly advantageRepository: Repository<Advantage>,
  ) {}

  async findAll(): Promise<Advantage[]> {
    return this.advantageRepository.find();
  }

  async findInIds(ids: string[]): Promise<Advantage[]> {
    return this.advantageRepository.find({ where: { id: In(ids) } });
  }

  async findById(id: string): Promise<Advantage> {
    return this.advantageRepository.findOne({ where: { id } });
  }

  async findByIdAndRelations(id: string): Promise<Advantage> {
    return this.advantageRepository.findOne({ where: { id }, relations: { orders: true, cars: true } });
  }

  async create(createAdvantageDto: CreateAdvantageDto): Promise<Advantage> {
    const newAdvantage = this.advantageRepository.create(createAdvantageDto);
    return this.advantageRepository.save(newAdvantage);
  }

  async update(advantage: Advantage, updateAdvantageDto: UpdateAdvantageDto): Promise<Advantage> {
    const updatedAdvantage = Object.assign(advantage, updateAdvantageDto);
    await this.advantageRepository.save(updatedAdvantage);
    return this.findById(advantage.id);
  }

  async disactive(advantage: Advantage): Promise<void> {
    advantage.active = false;
    await this.advantageRepository.save(advantage);
  }

  async delete(advantage: Advantage): Promise<void> {
    await this.advantageRepository.softRemove(advantage);
  }
}
