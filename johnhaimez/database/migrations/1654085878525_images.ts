import BaseSchema from "@ioc:Adonis/Lucid/Schema";

export default class extends BaseSchema {
  protected tableName = "images";

  public async up() {
    this.schema.createTable(this.tableName, (table) => {
      table.increments("id").primary();
      table.string("name");
      table.text("path", "mediumtext");
      table
        .integer("link_id")
        .unsigned()
        .references("links.id")
        .onDelete("CASCADE");
      table
        .integer("hardskill_id")
        .unsigned()
        .references("hardskills.id")
        .onDelete("CASCADE");
      table
        .integer("softskill_id")
        .unsigned()
        .references("softskills.id")
        .onDelete("CASCADE");
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
