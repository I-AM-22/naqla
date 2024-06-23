import { MigrationInterface, QueryRunner } from "typeorm";

export class Message1719175619027 implements MigrationInterface {
    name = 'Message1719175619027'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "messages" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "content" character varying NOT NULL, "isUser" boolean NOT NULL, "subOrderId" uuid NOT NULL, CONSTRAINT "PK_18325f38ae6de43878487eff986" PRIMARY KEY ("id"))`);
        await queryRunner.query(`ALTER TABLE "messages" ADD CONSTRAINT "FK_3a48622d4e307f2337dcd4b12bf" FOREIGN KEY ("subOrderId") REFERENCES "sub_orders"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "messages" DROP CONSTRAINT "FK_3a48622d4e307f2337dcd4b12bf"`);
        await queryRunner.query(`DROP TABLE "messages"`);
    }

}
