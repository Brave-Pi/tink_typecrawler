package;

import haxe.macro.Expr;
import haxe.macro.Type;
import tink.typecrawler.Generator;
import tink.typecrawler.FieldInfo;

using tink.MacroApi;
using tink.CoreApi;

class Gen {
  public function new() {}
  public function nullable(e:Array<Field>):Array<Field> return throw 'abstract';
  public function string():Array<Field> return throw 'abstract';
  public function float():Array<Field> return throw 'abstract';
  public function int():Array<Field> return throw 'abstract';
  public function dyn(e:Array<Field>, ct:ComplexType):Array<Field> return throw 'abstract';
  public function dynAccess(e:Array<Field>):Array<Field> return throw 'abstract';
  public function bool():Array<Field> return throw 'abstract';
  public function date():Array<Field> return throw 'abstract';
  public function bytes():Array<Field> return throw 'abstract';
  public function anon(fields:Array<FieldInfo<Array<Field>>>, ct:ComplexType):Array<Field> return throw 'abstract';
  public function array(e:Array<Field>):Array<Field> return throw 'abstract';
  public function map(k:Type, v:Array<Field>):Array<Field> return throw 'abstract';
  public function enm(constructors:Array<EnumConstructor<Array<Field>>>, ct:ComplexType, pos:Position, gen:GenType<Array<Field>>):Array<Field> return throw 'abstract';
  public function enumAbstract(names:Array<Expr>, e:Array<Field>, ct:ComplexType, pos:Position):Array<Field> return throw 'abstract';
  public function rescue(t:Type, pos:Position, gen:GenType<Array<Field>>):Option<Array<Field>> return throw 'abstract';
  public function reject(t:Type):String return throw 'abstract';
  public function shouldIncludeField(c:ClassField, owner:Option<ClassType>):Bool return true;
  public function drive(type:Type, pos:Position, gen:GenType<Array<Field>>):Array<Field> return gen(type, pos);
}