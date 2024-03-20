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
    await queryRunner.query(
      `CREATE TABLE "advantage" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "name" character varying NOT NULL, "cost" numeric(10,2) NOT NULL, "active" boolean NOT NULL DEFAULT true, CONSTRAINT "PK_7b3a018bf20774169ed749b920c" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "cars_advantages_advantage" ("carsId" uuid NOT NULL, "advantageId" uuid NOT NULL, CONSTRAINT "PK_1e2de39e4117b7e31e0f919078d" PRIMARY KEY ("carsId", "advantageId"))`,
    );
    await queryRunner.query(
      `CREATE INDEX "IDX_e685928f08058080acb9e54a42" ON "cars_advantages_advantage" ("carsId") `,
    );
    await queryRunner.query(
      `CREATE INDEX "IDX_4f97bd9faed94d750a9381fa96" ON "cars_advantages_advantage" ("advantageId") `,
    );
    await queryRunner.query(`ALTER TABLE "cars" DROP COLUMN "active"`);
    await queryRunner.query(
      `ALTER TABLE "cars" ADD "active" boolean NOT NULL DEFAULT true`,
    );
    await queryRunner.query(
      `ALTER TABLE "cars_advantages_advantage" ADD CONSTRAINT "FK_e685928f08058080acb9e54a428" FOREIGN KEY ("carsId") REFERENCES "cars"("id") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
    await queryRunner.query(
      `ALTER TABLE "cars_advantages_advantage" ADD CONSTRAINT "FK_4f97bd9faed94d750a9381fa960" FOREIGN KEY ("advantageId") REFERENCES "advantage"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "cars_advantages_advantage" DROP CONSTRAINT "FK_4f97bd9faed94d750a9381fa960"`,
    );
    await queryRunner.query(
      `ALTER TABLE "cars_advantages_advantage" DROP CONSTRAINT "FK_e685928f08058080acb9e54a428"`,
    );
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
