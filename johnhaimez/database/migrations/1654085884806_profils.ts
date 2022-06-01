import BaseSchema from "@ioc:Adonis/Lucid/Schema";

export default class extends BaseSchema {
  protected tableName = "profils";

  public async up() {
    this.schema.createTable(this.tableName, (table) => {
      table.increments("id").primary();
      table.string("firstname");
      table.string("lastname");
      table.string("username");
      table.string("address");
      table.string("code_post");
      table.string("city");
      table.string("tel");
      table.string("email");
      table.string("title");
      table.string("copyright");
      table.text("description", "mediumtext");
      table.integer("image_id");
      /**
       * Uses timestamptz for PostgreSQL and DATETIME2 for MSSQL
       */
      table.timestamp("created_at", { useTz: true });
      table.timestamp("updated_at", { useTz: true });
    });
  }

  public async down() {
    this.schema.dropTable(this.tableName);
  }
}
