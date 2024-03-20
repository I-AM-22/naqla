import { MigrationInterface, QueryRunner } from "typeorm";

export class AdvantagesCars1710938698216 implements MigrationInterface {
    name = 'AdvantagesCars1710938698216'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "cars_advantages" ("carsId" uuid NOT NULL, "advantagesId" uuid NOT NULL, CONSTRAINT "PK_df887fde0e193836aff5bd79a22" PRIMARY KEY ("carsId", "advantagesId"))`);
        await queryRunner.query(`CREATE INDEX "IDX_5bc2c6cef1d463eebf2116df20" ON "cars_advantages" ("carsId") `);
        await queryRunner.query(`CREATE INDEX "IDX_190ac39adcc281ba12a261e03f" ON "cars_advantages" ("advantagesId") `);
        await queryRunner.query(`ALTER TABLE "cars_advantages" ADD CONSTRAINT "FK_5bc2c6cef1d463eebf2116df20d" FOREIGN KEY ("carsId") REFERENCES "cars"("id") ON DELETE CASCADE ON UPDATE CASCADE`);
        await queryRunner.query(`ALTER TABLE "cars_advantages" ADD CONSTRAINT "FK_190ac39adcc281ba12a261e03f0" FOREIGN KEY ("advantagesId") REFERENCES "advantages"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "cars_advantages" DROP CONSTRAINT "FK_190ac39adcc281ba12a261e03f0"`);
        await queryRunner.query(`ALTER TABLE "cars_advantages" DROP CONSTRAINT "FK_5bc2c6cef1d463eebf2116df20d"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_190ac39adcc281ba12a261e03f"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_5bc2c6cef1d463eebf2116df20"`);
        await queryRunner.query(`DROP TABLE "cars_advantages"`);
    }

}
