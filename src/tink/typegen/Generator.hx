package tink.typegen;

import haxe.macro.Expr;
import haxe.macro.Type;
import tink.typegen.FieldInfo;

using tink.CoreApi;

typedef GenType<T> = Type->Position->T;

typedef Generator<T> = {
	// function args():Array<String>;
	// function wrap(placeholder:T, ct:ComplexType):Function;
	function nullable(e:T):T;
	function string():T;
	function float():T;
	function int():T;
	function dyn(e:Type, ct:ComplexType):T;
	function dynAccess(e:T):T;
	function bool():T;
	function date():T;
	function bytes():T;
	function anon(fields:Array<FieldInfo<T>>, ct:ComplexType):T;
	function array(e:Type):T;
	function map(k:Type, v:Type):T;
	function enm(constructors:Array<EnumConstructor<T>>, ct:ComplexType, pos:Position, gen:GenType<T>):T;
	function enumAbstract(names:Array<Expr>, e:T, ct:ComplexType, pos:Position):T;
	function rescue(t:Type, pos:Position, gen:GenType<T>):Option<T>;
	function reject(t:Type):String;
	function shouldIncludeField(c:ClassField, owner:Option<ClassType>):Bool;
	function drive(type:Type, pos:Position, gen:GenType<T>):T;
}

typedef EnumConstructor<T> = {
	inlined:Bool,
	ctor:EnumField,
	fields:Array<FieldInfo<T>>,
}

class Helper {
	public static function shouldIncludeField(f:ClassField, owner:Option<ClassType>):Bool {
		if (!f.meta.has(':transient'))
			switch f.kind {
				case FVar(AccNever | AccCall, AccNever | AccCall):
					if (f.meta.has(':isVar'))
						return true;
				case FVar(read, write):
					return true;
				default:
			}
		return false;
	}
}
