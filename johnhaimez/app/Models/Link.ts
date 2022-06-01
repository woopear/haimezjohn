import { DateTime } from "luxon";
import { BaseModel, column } from "@ioc:Adonis/Lucid/Orm";

export default class Link extends BaseModel {
  @column({ isPrimary: true })
  public id: number;

  @column()
  public libelle: string;

  @column()
  public path: string;

  @column()
  public imageId: number;

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime;

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime;
}
