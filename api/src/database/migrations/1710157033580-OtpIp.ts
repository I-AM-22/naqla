import { MigrationInterface, QueryRunner } from 'typeorm';

export class OtpIp1710157033580 implements MigrationInterface {
  name = 'OtpIp1710157033580';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "otps" ADD "ip" character varying NOT NULL`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`ALTER TABLE "otps" DROP COLUMN "ip"`);
  }
}
