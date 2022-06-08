import { DateTime } from "luxon";
import { BaseModel, column, HasOne, hasOne } from "@ioc:Adonis/Lucid/Orm";
import Profil from "./Profil";

export default class Image extends BaseModel {
  @column({ isPrimary: true })
  public id: number;

  @column()
  public name: string;

  @column()
  public path: string;

  @column()
  public hardskillId: number | null;

  @column()
  public softskillId: number | null;

  @column()
  public linkId: number | null;

  @column()
  public competenceId: number | null;

  @hasOne(() => Profil)
  public profil: HasOne<typeof Profil>;

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime;

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime;
}
