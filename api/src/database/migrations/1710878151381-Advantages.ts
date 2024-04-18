import { MigrationInterface, QueryRunner } from 'typeorm';

export class Advantages1710878151381 implements MigrationInterface {
  name = 'Advantages1710878151381';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "cars" DROP CONSTRAINT "FK_52439e2ced840f1d17e17c27d2e"`,
    );
    await queryRunner.query(
      `ALTER TABLE "cars" RENAME COLUMN "photoId" TO "active"`,
    );

    await queryRunner.query(`ALTER TABLE "cars" DROP COLUMN "active"`);
    await queryRunner.query(
      `ALTER TABLE "cars" ADD "active" boolean NOT NULL DEFAULT true`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`ALTER TABLE "cars" DROP COLUMN "active"`);
    await queryRunner.query(`ALTER TABLE "cars" ADD "active" uuid`);
    await queryRunner.query(
      `DROP INDEX "public"."IDX_4f97bd9faed94d750a9381fa96"`,
    );
    await queryRunner.query(
      `DROP INDEX "public"."IDX_e685928f08058080acb9e54a42"`,
    );
    await queryRunner.query(`DROP TABLE "cars_advantages_advantage"`);
    await queryRunner.query(`DROP TABLE "advantage"`);
    await queryRunner.query(
      `ALTER TABLE "cars" RENAME COLUMN "active" TO "photoId"`,
    );
    await queryRunner.query(
      `ALTER TABLE "cars" ADD CONSTRAINT "FK_52439e2ced840f1d17e17c27d2e" FOREIGN KEY ("photoId") REFERENCES "cars_photos"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
  }
}
