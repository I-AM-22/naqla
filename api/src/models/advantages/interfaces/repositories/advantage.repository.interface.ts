import { CreateAdvantageDto, UpdateAdvantageDto } from '../../dto';
import { Advantage } from '../../entities/advantage.entity';

export interface IAdvantageRepository {
  findAll(): Promise<Advantage[]>;
  findInIds(ids: string[]): Promise<Advantage[]>;
  findById(id: string): Promise<Advantage>;
  findByIdAndRelations(id: string): Promise<Advantage>;
  create(createAdvantageDto: CreateAdvantageDto): Promise<Advantage>;
  update(advantage: Advantage, updateAdvantageDto: UpdateAdvantageDto): Promise<Advantage>;
  disactive(advantage: Advantage): Promise<void>;
  delete(advantage: Advantage): Promise<void>;
}
