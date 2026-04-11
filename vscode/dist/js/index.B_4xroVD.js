import { t as __exportAll } from "./rolldown-runtime.Et-JK1ip.js";
//#region \0vite/modulepreload-polyfill.js
(function polyfill() {
	const relList = document.createElement("link").relList;
	if (relList && relList.supports && relList.supports("modulepreload")) return;
	for (const link of document.querySelectorAll("link[rel=\"modulepreload\"]")) processPreload(link);
	new MutationObserver((mutations) => {
		for (const mutation of mutations) {
			if (mutation.type !== "childList") continue;
			for (const node of mutation.addedNodes) if (node.tagName === "LINK" && node.rel === "modulepreload") processPreload(node);
		}
	}).observe(document, {
		childList: true,
		subtree: true
	});
	function getFetchOpts(link) {
		const fetchOpts = {};
		if (link.integrity) fetchOpts.integrity = link.integrity;
		if (link.referrerPolicy) fetchOpts.referrerPolicy = link.referrerPolicy;
		if (link.crossOrigin === "use-credentials") fetchOpts.credentials = "include";
		else if (link.crossOrigin === "anonymous") fetchOpts.credentials = "omit";
		else fetchOpts.credentials = "same-origin";
		return fetchOpts;
	}
	function processPreload(link) {
		if (link.ep) return;
		link.ep = true;
		const fetchOpts = getFetchOpts(link);
		fetch(link.href, fetchOpts);
	}
})();
//#endregion
//#region node_modules/@vue/shared/dist/shared.esm-bundler.js
/**
* @vue/shared v3.4.29
* (c) 2018-present Yuxi (Evan) You and Vue contributors
* @license MIT
**/
/*! #__NO_SIDE_EFFECTS__ */
/* @__NO_SIDE_EFFECTS__ */
function makeMap(str, expectsLowerCase) {
	const set = new Set(str.split(","));
	return expectsLowerCase ? (val) => set.has(val.toLowerCase()) : (val) => set.has(val);
}
var EMPTY_OBJ = {};
var EMPTY_ARR = [];
var NOOP = () => {};
var NO = () => false;
var isOn = (key) => key.charCodeAt(0) === 111 && key.charCodeAt(1) === 110 && (key.charCodeAt(2) > 122 || key.charCodeAt(2) < 97);
var isModelListener = (key) => key.startsWith("onUpdate:");
var extend = Object.assign;
var remove = (arr, el) => {
	const i = arr.indexOf(el);
	if (i > -1) arr.splice(i, 1);
};
var hasOwnProperty$1 = Object.prototype.hasOwnProperty;
var hasOwn = (val, key) => hasOwnProperty$1.call(val, key);
var isArray$1 = Array.isArray;
var isMap = (val) => toTypeString(val) === "[object Map]";
var isSet = (val) => toTypeString(val) === "[object Set]";
var isDate = (val) => toTypeString(val) === "[object Date]";
var isRegExp = (val) => toTypeString(val) === "[object RegExp]";
var isFunction = (val) => typeof val === "function";
var isString = (val) => typeof val === "string";
var isSymbol = (val) => typeof val === "symbol";
var isObject = (val) => val !== null && typeof val === "object";
var isPromise = (val) => {
	return (isObject(val) || isFunction(val)) && isFunction(val.then) && isFunction(val.catch);
};
var objectToString = Object.prototype.toString;
var toTypeString = (value) => objectToString.call(value);
var toRawType = (value) => {
	return toTypeString(value).slice(8, -1);
};
var isPlainObject = (val) => toTypeString(val) === "[object Object]";
var isIntegerKey = (key) => isString(key) && key !== "NaN" && key[0] !== "-" && "" + parseInt(key, 10) === key;
var isReservedProp = /* @__PURE__ */ makeMap(",key,ref,ref_for,ref_key,onVnodeBeforeMount,onVnodeMounted,onVnodeBeforeUpdate,onVnodeUpdated,onVnodeBeforeUnmount,onVnodeUnmounted");
var cacheStringFunction = (fn) => {
	const cache = /* @__PURE__ */ Object.create(null);
	return (str) => {
		return cache[str] || (cache[str] = fn(str));
	};
};
var camelizeRE = /-(\w)/g;
var camelize = cacheStringFunction((str) => {
	return str.replace(camelizeRE, (_, c) => c ? c.toUpperCase() : "");
});
var hyphenateRE = /\B([A-Z])/g;
var hyphenate = cacheStringFunction((str) => str.replace(hyphenateRE, "-$1").toLowerCase());
var capitalize = cacheStringFunction((str) => {
	return str.charAt(0).toUpperCase() + str.slice(1);
});
var toHandlerKey = cacheStringFunction((str) => {
	return str ? `on${capitalize(str)}` : ``;
});
var hasChanged = (value, oldValue) => !Object.is(value, oldValue);
var invokeArrayFns = (fns, ...arg) => {
	for (let i = 0; i < fns.length; i++) fns[i](...arg);
};
var def = (obj, key, value, writable = false) => {
	Object.defineProperty(obj, key, {
		configurable: true,
		enumerable: false,
		writable,
		value
	});
};
var looseToNumber = (val) => {
	const n = parseFloat(val);
	return isNaN(n) ? val : n;
};
var toNumber = (val) => {
	const n = isString(val) ? Number(val) : NaN;
	return isNaN(n) ? val : n;
};
var _globalThis;
var getGlobalThis = () => {
	return _globalThis || (_globalThis = typeof globalThis !== "undefined" ? globalThis : typeof self !== "undefined" ? self : typeof window !== "undefined" ? window : typeof global !== "undefined" ? global : {});
};
var isGloballyAllowed = /* @__PURE__ */ makeMap("Infinity,undefined,NaN,isFinite,isNaN,parseFloat,parseInt,decodeURI,decodeURIComponent,encodeURI,encodeURIComponent,Math,Number,Date,Array,Object,Boolean,String,RegExp,Map,Set,JSON,Intl,BigInt,console,Error");
function normalizeStyle(value) {
	if (isArray$1(value)) {
		const res = {};
		for (let i = 0; i < value.length; i++) {
			const item = value[i];
			const normalized = isString(item) ? parseStringStyle(item) : normalizeStyle(item);
			if (normalized) for (const key in normalized) res[key] = normalized[key];
		}
		return res;
	} else if (isString(value) || isObject(value)) return value;
}
var listDelimiterRE = /;(?![^(]*\))/g;
var propertyDelimiterRE = /:([^]+)/;
var styleCommentRE = /\/\*[^]*?\*\//g;
function parseStringStyle(cssText) {
	const ret = {};
	cssText.replace(styleCommentRE, "").split(listDelimiterRE).forEach((item) => {
		if (item) {
			const tmp = item.split(propertyDelimiterRE);
			tmp.length > 1 && (ret[tmp[0].trim()] = tmp[1].trim());
		}
	});
	return ret;
}
function normalizeClass(value) {
	let res = "";
	if (isString(value)) res = value;
	else if (isArray$1(value)) for (let i = 0; i < value.length; i++) {
		const normalized = normalizeClass(value[i]);
		if (normalized) res += normalized + " ";
	}
	else if (isObject(value)) {
		for (const name in value) if (value[name]) res += name + " ";
	}
	return res.trim();
}
function normalizeProps(props) {
	if (!props) return null;
	let { class: klass, style } = props;
	if (klass && !isString(klass)) props.class = normalizeClass(klass);
	if (style) props.style = normalizeStyle(style);
	return props;
}
var specialBooleanAttrs = `itemscope,allowfullscreen,formnovalidate,ismap,nomodule,novalidate,readonly`;
var isSpecialBooleanAttr = /* @__PURE__ */ makeMap(specialBooleanAttrs);
specialBooleanAttrs + "";
function includeBooleanAttr(value) {
	return !!value || value === "";
}
function looseCompareArrays(a, b) {
	if (a.length !== b.length) return false;
	let equal = true;
	for (let i = 0; equal && i < a.length; i++) equal = looseEqual(a[i], b[i]);
	return equal;
}
function looseEqual(a, b) {
	if (a === b) return true;
	let aValidType = isDate(a);
	let bValidType = isDate(b);
	if (aValidType || bValidType) return aValidType && bValidType ? a.getTime() === b.getTime() : false;
	aValidType = isSymbol(a);
	bValidType = isSymbol(b);
	if (aValidType || bValidType) return a === b;
	aValidType = isArray$1(a);
	bValidType = isArray$1(b);
	if (aValidType || bValidType) return aValidType && bValidType ? looseCompareArrays(a, b) : false;
	aValidType = isObject(a);
	bValidType = isObject(b);
	if (aValidType || bValidType) {
		if (!aValidType || !bValidType) return false;
		if (Object.keys(a).length !== Object.keys(b).length) return false;
		for (const key in a) {
			const aHasKey = a.hasOwnProperty(key);
			const bHasKey = b.hasOwnProperty(key);
			if (aHasKey && !bHasKey || !aHasKey && bHasKey || !looseEqual(a[key], b[key])) return false;
		}
	}
	return String(a) === String(b);
}
function looseIndexOf(arr, val) {
	return arr.findIndex((item) => looseEqual(item, val));
}
var toDisplayString = (val) => {
	return isString(val) ? val : val == null ? "" : isArray$1(val) || isObject(val) && (val.toString === objectToString || !isFunction(val.toString)) ? JSON.stringify(val, replacer, 2) : String(val);
};
var replacer = (_key, val) => {
	if (val && val.__v_isRef) return replacer(_key, val.value);
	else if (isMap(val)) return { [`Map(${val.size})`]: [...val.entries()].reduce((entries, [key, val2], i) => {
		entries[stringifySymbol(key, i) + " =>"] = val2;
		return entries;
	}, {}) };
	else if (isSet(val)) return { [`Set(${val.size})`]: [...val.values()].map((v) => stringifySymbol(v)) };
	else if (isSymbol(val)) return stringifySymbol(val);
	else if (isObject(val) && !isArray$1(val) && !isPlainObject(val)) return String(val);
	return val;
};
var stringifySymbol = (v, i = "") => {
	var _a;
	return isSymbol(v) ? `Symbol(${(_a = v.description) != null ? _a : i})` : v;
};
//#endregion
//#region node_modules/@vue/reactivity/dist/reactivity.esm-bundler.js
/**
* @vue/reactivity v3.4.29
* (c) 2018-present Yuxi (Evan) You and Vue contributors
* @license MIT
**/
var activeEffectScope;
var EffectScope = class {
	constructor(detached = false) {
		this.detached = detached;
		/**
		* @internal
		*/
		this._active = true;
		/**
		* @internal
		*/
		this.effects = [];
		/**
		* @internal
		*/
		this.cleanups = [];
		this.parent = activeEffectScope;
		if (!detached && activeEffectScope) this.index = (activeEffectScope.scopes || (activeEffectScope.scopes = [])).push(this) - 1;
	}
	get active() {
		return this._active;
	}
	run(fn) {
		if (this._active) {
			const currentEffectScope = activeEffectScope;
			try {
				activeEffectScope = this;
				return fn();
			} finally {
				activeEffectScope = currentEffectScope;
			}
		}
	}
	/**
	* This should only be called on non-detached scopes
	* @internal
	*/
	on() {
		activeEffectScope = this;
	}
	/**
	* This should only be called on non-detached scopes
	* @internal
	*/
	off() {
		activeEffectScope = this.parent;
	}
	stop(fromParent) {
		if (this._active) {
			let i, l;
			for (i = 0, l = this.effects.length; i < l; i++) this.effects[i].stop();
			for (i = 0, l = this.cleanups.length; i < l; i++) this.cleanups[i]();
			if (this.scopes) for (i = 0, l = this.scopes.length; i < l; i++) this.scopes[i].stop(true);
			if (!this.detached && this.parent && !fromParent) {
				const last = this.parent.scopes.pop();
				if (last && last !== this) {
					this.parent.scopes[this.index] = last;
					last.index = this.index;
				}
			}
			this.parent = void 0;
			this._active = false;
		}
	}
};
function effectScope(detached) {
	return new EffectScope(detached);
}
function recordEffectScope(effect, scope = activeEffectScope) {
	if (scope && scope.active) scope.effects.push(effect);
}
function getCurrentScope() {
	return activeEffectScope;
}
function onScopeDispose(fn) {
	if (activeEffectScope) activeEffectScope.cleanups.push(fn);
}
var activeEffect;
var ReactiveEffect = class {
	constructor(fn, trigger, scheduler, scope) {
		this.fn = fn;
		this.trigger = trigger;
		this.scheduler = scheduler;
		this.active = true;
		this.deps = [];
		/**
		* @internal
		*/
		this._dirtyLevel = 5;
		/**
		* @internal
		*/
		this._trackId = 0;
		/**
		* @internal
		*/
		this._runnings = 0;
		/**
		* @internal
		*/
		this._shouldSchedule = false;
		/**
		* @internal
		*/
		this._depsLength = 0;
		recordEffectScope(this, scope);
	}
	get dirty() {
		if (this._dirtyLevel === 2) return false;
		if (this._dirtyLevel === 3 || this._dirtyLevel === 4) {
			this._dirtyLevel = 1;
			pauseTracking();
			for (let i = 0; i < this._depsLength; i++) {
				const dep = this.deps[i];
				if (dep.computed) {
					if (dep.computed.effect._dirtyLevel === 2) return true;
					triggerComputed(dep.computed);
					if (this._dirtyLevel >= 5) break;
				}
			}
			if (this._dirtyLevel === 1) this._dirtyLevel = 0;
			resetTracking();
		}
		return this._dirtyLevel >= 5;
	}
	set dirty(v) {
		this._dirtyLevel = v ? 5 : 0;
	}
	run() {
		this._dirtyLevel = 0;
		if (!this.active) return this.fn();
		let lastShouldTrack = shouldTrack;
		let lastEffect = activeEffect;
		try {
			shouldTrack = true;
			activeEffect = this;
			this._runnings++;
			preCleanupEffect(this);
			return this.fn();
		} finally {
			postCleanupEffect(this);
			this._runnings--;
			activeEffect = lastEffect;
			shouldTrack = lastShouldTrack;
		}
	}
	stop() {
		if (this.active) {
			preCleanupEffect(this);
			postCleanupEffect(this);
			this.onStop && this.onStop();
			this.active = false;
		}
	}
};
function triggerComputed(computed) {
	return computed.value;
}
function preCleanupEffect(effect2) {
	effect2._trackId++;
	effect2._depsLength = 0;
}
function postCleanupEffect(effect2) {
	if (effect2.deps.length > effect2._depsLength) {
		for (let i = effect2._depsLength; i < effect2.deps.length; i++) cleanupDepEffect(effect2.deps[i], effect2);
		effect2.deps.length = effect2._depsLength;
	}
}
function cleanupDepEffect(dep, effect2) {
	const trackId = dep.get(effect2);
	if (trackId !== void 0 && effect2._trackId !== trackId) {
		dep.delete(effect2);
		if (dep.size === 0) dep.cleanup();
	}
}
function effect(fn, options) {
	if (fn.effect instanceof ReactiveEffect) fn = fn.effect.fn;
	const _effect = new ReactiveEffect(fn, NOOP, () => {
		if (_effect.dirty) _effect.run();
	});
	if (options) {
		extend(_effect, options);
		if (options.scope) recordEffectScope(_effect, options.scope);
	}
	if (!options || !options.lazy) _effect.run();
	const runner = _effect.run.bind(_effect);
	runner.effect = _effect;
	return runner;
}
function stop(runner) {
	runner.effect.stop();
}
var shouldTrack = true;
var pauseScheduleStack = 0;
var trackStack = [];
function pauseTracking() {
	trackStack.push(shouldTrack);
	shouldTrack = false;
}
function resetTracking() {
	const last = trackStack.pop();
	shouldTrack = last === void 0 ? true : last;
}
function pauseScheduling() {
	pauseScheduleStack++;
}
function resetScheduling() {
	pauseScheduleStack--;
	while (!pauseScheduleStack && queueEffectSchedulers.length) queueEffectSchedulers.shift()();
}
function trackEffect(effect2, dep, debuggerEventExtraInfo) {
	if (dep.get(effect2) !== effect2._trackId) {
		dep.set(effect2, effect2._trackId);
		const oldDep = effect2.deps[effect2._depsLength];
		if (oldDep !== dep) {
			if (oldDep) cleanupDepEffect(oldDep, effect2);
			effect2.deps[effect2._depsLength++] = dep;
		} else effect2._depsLength++;
	}
}
var queueEffectSchedulers = [];
function triggerEffects(dep, dirtyLevel, debuggerEventExtraInfo) {
	pauseScheduling();
	for (const effect2 of dep.keys()) {
		if (!dep.computed && effect2.computed) {
			if (dep.get(effect2) === effect2._trackId && effect2._runnings > 0) {
				effect2._dirtyLevel = 2;
				continue;
			}
		}
		let tracking;
		if (effect2._dirtyLevel < dirtyLevel && (tracking != null ? tracking : tracking = dep.get(effect2) === effect2._trackId)) {
			effect2._shouldSchedule || (effect2._shouldSchedule = effect2._dirtyLevel === 0);
			if (effect2.computed && effect2._dirtyLevel === 2) effect2._shouldSchedule = true;
			effect2._dirtyLevel = dirtyLevel;
		}
		if (effect2._shouldSchedule && (tracking != null ? tracking : tracking = dep.get(effect2) === effect2._trackId)) {
			effect2.trigger();
			if ((!effect2._runnings || effect2.allowRecurse) && effect2._dirtyLevel !== 3) {
				effect2._shouldSchedule = false;
				if (effect2.scheduler) queueEffectSchedulers.push(effect2.scheduler);
			}
		}
	}
	resetScheduling();
}
var createDep = (cleanup, computed) => {
	const dep = /* @__PURE__ */ new Map();
	dep.cleanup = cleanup;
	dep.computed = computed;
	return dep;
};
var targetMap = /* @__PURE__ */ new WeakMap();
var ITERATE_KEY = Symbol("");
var MAP_KEY_ITERATE_KEY = Symbol("");
function track(target, type, key) {
	if (shouldTrack && activeEffect) {
		let depsMap = targetMap.get(target);
		if (!depsMap) targetMap.set(target, depsMap = /* @__PURE__ */ new Map());
		let dep = depsMap.get(key);
		if (!dep) depsMap.set(key, dep = createDep(() => depsMap.delete(key)));
		trackEffect(activeEffect, dep, void 0);
	}
}
function trigger(target, type, key, newValue, oldValue, oldTarget) {
	const depsMap = targetMap.get(target);
	if (!depsMap) return;
	let deps = [];
	if (type === "clear") deps = [...depsMap.values()];
	else if (key === "length" && isArray$1(target)) {
		const newLength = Number(newValue);
		depsMap.forEach((dep, key2) => {
			if (key2 === "length" || !isSymbol(key2) && key2 >= newLength) deps.push(dep);
		});
	} else {
		if (key !== void 0) deps.push(depsMap.get(key));
		switch (type) {
			case "add":
				if (!isArray$1(target)) {
					deps.push(depsMap.get(ITERATE_KEY));
					if (isMap(target)) deps.push(depsMap.get(MAP_KEY_ITERATE_KEY));
				} else if (isIntegerKey(key)) deps.push(depsMap.get("length"));
				break;
			case "delete":
				if (!isArray$1(target)) {
					deps.push(depsMap.get(ITERATE_KEY));
					if (isMap(target)) deps.push(depsMap.get(MAP_KEY_ITERATE_KEY));
				}
				break;
			case "set":
				if (isMap(target)) deps.push(depsMap.get(ITERATE_KEY));
				break;
		}
	}
	pauseScheduling();
	for (const dep of deps) if (dep) triggerEffects(dep, 5, void 0);
	resetScheduling();
}
function getDepFromReactive(object, key) {
	const depsMap = targetMap.get(object);
	return depsMap && depsMap.get(key);
}
var isNonTrackableKeys = /* @__PURE__ */ makeMap(`__proto__,__v_isRef,__isVue`);
var builtInSymbols = new Set(/* @__PURE__ */ Object.getOwnPropertyNames(Symbol).filter((key) => key !== "arguments" && key !== "caller").map((key) => Symbol[key]).filter(isSymbol));
var arrayInstrumentations = /* @__PURE__ */ createArrayInstrumentations();
function createArrayInstrumentations() {
	const instrumentations = {};
	[
		"includes",
		"indexOf",
		"lastIndexOf"
	].forEach((key) => {
		instrumentations[key] = function(...args) {
			const arr = toRaw(this);
			for (let i = 0, l = this.length; i < l; i++) track(arr, "get", i + "");
			const res = arr[key](...args);
			if (res === -1 || res === false) return arr[key](...args.map(toRaw));
			else return res;
		};
	});
	[
		"push",
		"pop",
		"shift",
		"unshift",
		"splice"
	].forEach((key) => {
		instrumentations[key] = function(...args) {
			pauseTracking();
			pauseScheduling();
			const res = toRaw(this)[key].apply(this, args);
			resetScheduling();
			resetTracking();
			return res;
		};
	});
	return instrumentations;
}
function hasOwnProperty(key) {
	if (!isSymbol(key)) key = String(key);
	const obj = toRaw(this);
	track(obj, "has", key);
	return obj.hasOwnProperty(key);
}
var BaseReactiveHandler = class {
	constructor(_isReadonly = false, _isShallow = false) {
		this._isReadonly = _isReadonly;
		this._isShallow = _isShallow;
	}
	get(target, key, receiver) {
		const isReadonly2 = this._isReadonly, isShallow2 = this._isShallow;
		if (key === "__v_isReactive") return !isReadonly2;
		else if (key === "__v_isReadonly") return isReadonly2;
		else if (key === "__v_isShallow") return isShallow2;
		else if (key === "__v_raw") {
			if (receiver === (isReadonly2 ? isShallow2 ? shallowReadonlyMap : readonlyMap : isShallow2 ? shallowReactiveMap : reactiveMap).get(target) || Object.getPrototypeOf(target) === Object.getPrototypeOf(receiver)) return target;
			return;
		}
		const targetIsArray = isArray$1(target);
		if (!isReadonly2) {
			if (targetIsArray && hasOwn(arrayInstrumentations, key)) return Reflect.get(arrayInstrumentations, key, receiver);
			if (key === "hasOwnProperty") return hasOwnProperty;
		}
		const res = Reflect.get(target, key, receiver);
		if (isSymbol(key) ? builtInSymbols.has(key) : isNonTrackableKeys(key)) return res;
		if (!isReadonly2) track(target, "get", key);
		if (isShallow2) return res;
		if (isRef(res)) return targetIsArray && isIntegerKey(key) ? res : res.value;
		if (isObject(res)) return isReadonly2 ? readonly(res) : reactive(res);
		return res;
	}
};
var MutableReactiveHandler = class extends BaseReactiveHandler {
	constructor(isShallow2 = false) {
		super(false, isShallow2);
	}
	set(target, key, value, receiver) {
		let oldValue = target[key];
		if (!this._isShallow) {
			const isOldValueReadonly = isReadonly(oldValue);
			if (!isShallow(value) && !isReadonly(value)) {
				oldValue = toRaw(oldValue);
				value = toRaw(value);
			}
			if (!isArray$1(target) && isRef(oldValue) && !isRef(value)) if (isOldValueReadonly) return false;
			else {
				oldValue.value = value;
				return true;
			}
		}
		const hadKey = isArray$1(target) && isIntegerKey(key) ? Number(key) < target.length : hasOwn(target, key);
		const result = Reflect.set(target, key, value, receiver);
		if (target === toRaw(receiver)) {
			if (!hadKey) trigger(target, "add", key, value);
			else if (hasChanged(value, oldValue)) trigger(target, "set", key, value, oldValue);
		}
		return result;
	}
	deleteProperty(target, key) {
		const hadKey = hasOwn(target, key);
		const oldValue = target[key];
		const result = Reflect.deleteProperty(target, key);
		if (result && hadKey) trigger(target, "delete", key, void 0, oldValue);
		return result;
	}
	has(target, key) {
		const result = Reflect.has(target, key);
		if (!isSymbol(key) || !builtInSymbols.has(key)) track(target, "has", key);
		return result;
	}
	ownKeys(target) {
		track(target, "iterate", isArray$1(target) ? "length" : ITERATE_KEY);
		return Reflect.ownKeys(target);
	}
};
var ReadonlyReactiveHandler = class extends BaseReactiveHandler {
	constructor(isShallow2 = false) {
		super(true, isShallow2);
	}
	set(target, key) {
		return true;
	}
	deleteProperty(target, key) {
		return true;
	}
};
var mutableHandlers = /* @__PURE__ */ new MutableReactiveHandler();
var readonlyHandlers = /* @__PURE__ */ new ReadonlyReactiveHandler();
var shallowReactiveHandlers = /* @__PURE__ */ new MutableReactiveHandler(true);
var shallowReadonlyHandlers = /* @__PURE__ */ new ReadonlyReactiveHandler(true);
var toShallow = (value) => value;
var getProto = (v) => Reflect.getPrototypeOf(v);
function get$1(target, key, isReadonly = false, isShallow = false) {
	target = target["__v_raw"];
	const rawTarget = toRaw(target);
	const rawKey = toRaw(key);
	if (!isReadonly) {
		if (hasChanged(key, rawKey)) track(rawTarget, "get", key);
		track(rawTarget, "get", rawKey);
	}
	const { has: has2 } = getProto(rawTarget);
	const wrap = isShallow ? toShallow : isReadonly ? toReadonly : toReactive;
	if (has2.call(rawTarget, key)) return wrap(target.get(key));
	else if (has2.call(rawTarget, rawKey)) return wrap(target.get(rawKey));
	else if (target !== rawTarget) target.get(key);
}
function has(key, isReadonly = false) {
	const target = this["__v_raw"];
	const rawTarget = toRaw(target);
	const rawKey = toRaw(key);
	if (!isReadonly) {
		if (hasChanged(key, rawKey)) track(rawTarget, "has", key);
		track(rawTarget, "has", rawKey);
	}
	return key === rawKey ? target.has(key) : target.has(key) || target.has(rawKey);
}
function size(target, isReadonly = false) {
	target = target["__v_raw"];
	!isReadonly && track(toRaw(target), "iterate", ITERATE_KEY);
	return Reflect.get(target, "size", target);
}
function add$1(value) {
	value = toRaw(value);
	const target = toRaw(this);
	if (!getProto(target).has.call(target, value)) {
		target.add(value);
		trigger(target, "add", value, value);
	}
	return this;
}
function set(key, value) {
	value = toRaw(value);
	const target = toRaw(this);
	const { has: has2, get: get2 } = getProto(target);
	let hadKey = has2.call(target, key);
	if (!hadKey) {
		key = toRaw(key);
		hadKey = has2.call(target, key);
	}
	const oldValue = get2.call(target, key);
	target.set(key, value);
	if (!hadKey) trigger(target, "add", key, value);
	else if (hasChanged(value, oldValue)) trigger(target, "set", key, value, oldValue);
	return this;
}
function deleteEntry(key) {
	const target = toRaw(this);
	const { has: has2, get: get2 } = getProto(target);
	let hadKey = has2.call(target, key);
	if (!hadKey) {
		key = toRaw(key);
		hadKey = has2.call(target, key);
	}
	const oldValue = get2 ? get2.call(target, key) : void 0;
	const result = target.delete(key);
	if (hadKey) trigger(target, "delete", key, void 0, oldValue);
	return result;
}
function clear() {
	const target = toRaw(this);
	const hadItems = target.size !== 0;
	const oldTarget = void 0;
	const result = target.clear();
	if (hadItems) trigger(target, "clear", void 0, void 0, oldTarget);
	return result;
}
function createForEach(isReadonly, isShallow) {
	return function forEach(callback, thisArg) {
		const observed = this;
		const target = observed["__v_raw"];
		const rawTarget = toRaw(target);
		const wrap = isShallow ? toShallow : isReadonly ? toReadonly : toReactive;
		!isReadonly && track(rawTarget, "iterate", ITERATE_KEY);
		return target.forEach((value, key) => {
			return callback.call(thisArg, wrap(value), wrap(key), observed);
		});
	};
}
function createIterableMethod(method, isReadonly, isShallow) {
	return function(...args) {
		const target = this["__v_raw"];
		const rawTarget = toRaw(target);
		const targetIsMap = isMap(rawTarget);
		const isPair = method === "entries" || method === Symbol.iterator && targetIsMap;
		const isKeyOnly = method === "keys" && targetIsMap;
		const innerIterator = target[method](...args);
		const wrap = isShallow ? toShallow : isReadonly ? toReadonly : toReactive;
		!isReadonly && track(rawTarget, "iterate", isKeyOnly ? MAP_KEY_ITERATE_KEY : ITERATE_KEY);
		return {
			next() {
				const { value, done } = innerIterator.next();
				return done ? {
					value,
					done
				} : {
					value: isPair ? [wrap(value[0]), wrap(value[1])] : wrap(value),
					done
				};
			},
			[Symbol.iterator]() {
				return this;
			}
		};
	};
}
function createReadonlyMethod(type) {
	return function(...args) {
		return type === "delete" ? false : type === "clear" ? void 0 : this;
	};
}
function createInstrumentations() {
	const mutableInstrumentations2 = {
		get(key) {
			return get$1(this, key);
		},
		get size() {
			return size(this);
		},
		has,
		add: add$1,
		set,
		delete: deleteEntry,
		clear,
		forEach: createForEach(false, false)
	};
	const shallowInstrumentations2 = {
		get(key) {
			return get$1(this, key, false, true);
		},
		get size() {
			return size(this);
		},
		has,
		add: add$1,
		set,
		delete: deleteEntry,
		clear,
		forEach: createForEach(false, true)
	};
	const readonlyInstrumentations2 = {
		get(key) {
			return get$1(this, key, true);
		},
		get size() {
			return size(this, true);
		},
		has(key) {
			return has.call(this, key, true);
		},
		add: createReadonlyMethod("add"),
		set: createReadonlyMethod("set"),
		delete: createReadonlyMethod("delete"),
		clear: createReadonlyMethod("clear"),
		forEach: createForEach(true, false)
	};
	const shallowReadonlyInstrumentations2 = {
		get(key) {
			return get$1(this, key, true, true);
		},
		get size() {
			return size(this, true);
		},
		has(key) {
			return has.call(this, key, true);
		},
		add: createReadonlyMethod("add"),
		set: createReadonlyMethod("set"),
		delete: createReadonlyMethod("delete"),
		clear: createReadonlyMethod("clear"),
		forEach: createForEach(true, true)
	};
	[
		"keys",
		"values",
		"entries",
		Symbol.iterator
	].forEach((method) => {
		mutableInstrumentations2[method] = createIterableMethod(method, false, false);
		readonlyInstrumentations2[method] = createIterableMethod(method, true, false);
		shallowInstrumentations2[method] = createIterableMethod(method, false, true);
		shallowReadonlyInstrumentations2[method] = createIterableMethod(method, true, true);
	});
	return [
		mutableInstrumentations2,
		readonlyInstrumentations2,
		shallowInstrumentations2,
		shallowReadonlyInstrumentations2
	];
}
var [mutableInstrumentations, readonlyInstrumentations, shallowInstrumentations, shallowReadonlyInstrumentations] = /* @__PURE__ */ createInstrumentations();
function createInstrumentationGetter(isReadonly, shallow) {
	const instrumentations = shallow ? isReadonly ? shallowReadonlyInstrumentations : shallowInstrumentations : isReadonly ? readonlyInstrumentations : mutableInstrumentations;
	return (target, key, receiver) => {
		if (key === "__v_isReactive") return !isReadonly;
		else if (key === "__v_isReadonly") return isReadonly;
		else if (key === "__v_raw") return target;
		return Reflect.get(hasOwn(instrumentations, key) && key in target ? instrumentations : target, key, receiver);
	};
}
var mutableCollectionHandlers = { get: /* @__PURE__ */ createInstrumentationGetter(false, false) };
var shallowCollectionHandlers = { get: /* @__PURE__ */ createInstrumentationGetter(false, true) };
var readonlyCollectionHandlers = { get: /* @__PURE__ */ createInstrumentationGetter(true, false) };
var shallowReadonlyCollectionHandlers = { get: /* @__PURE__ */ createInstrumentationGetter(true, true) };
var reactiveMap = /* @__PURE__ */ new WeakMap();
var shallowReactiveMap = /* @__PURE__ */ new WeakMap();
var readonlyMap = /* @__PURE__ */ new WeakMap();
var shallowReadonlyMap = /* @__PURE__ */ new WeakMap();
function targetTypeMap(rawType) {
	switch (rawType) {
		case "Object":
		case "Array": return 1;
		case "Map":
		case "Set":
		case "WeakMap":
		case "WeakSet": return 2;
		default: return 0;
	}
}
function getTargetType(value) {
	return value["__v_skip"] || !Object.isExtensible(value) ? 0 : targetTypeMap(toRawType(value));
}
function reactive(target) {
	if (isReadonly(target)) return target;
	return createReactiveObject(target, false, mutableHandlers, mutableCollectionHandlers, reactiveMap);
}
function shallowReactive(target) {
	return createReactiveObject(target, false, shallowReactiveHandlers, shallowCollectionHandlers, shallowReactiveMap);
}
function readonly(target) {
	return createReactiveObject(target, true, readonlyHandlers, readonlyCollectionHandlers, readonlyMap);
}
function shallowReadonly(target) {
	return createReactiveObject(target, true, shallowReadonlyHandlers, shallowReadonlyCollectionHandlers, shallowReadonlyMap);
}
function createReactiveObject(target, isReadonly2, baseHandlers, collectionHandlers, proxyMap) {
	if (!isObject(target)) return target;
	if (target["__v_raw"] && !(isReadonly2 && target["__v_isReactive"])) return target;
	const existingProxy = proxyMap.get(target);
	if (existingProxy) return existingProxy;
	const targetType = getTargetType(target);
	if (targetType === 0) return target;
	const proxy = new Proxy(target, targetType === 2 ? collectionHandlers : baseHandlers);
	proxyMap.set(target, proxy);
	return proxy;
}
function isReactive(value) {
	if (isReadonly(value)) return isReactive(value["__v_raw"]);
	return !!(value && value["__v_isReactive"]);
}
function isReadonly(value) {
	return !!(value && value["__v_isReadonly"]);
}
function isShallow(value) {
	return !!(value && value["__v_isShallow"]);
}
function isProxy(value) {
	return value ? !!value["__v_raw"] : false;
}
function toRaw(observed) {
	const raw = observed && observed["__v_raw"];
	return raw ? toRaw(raw) : observed;
}
function markRaw(value) {
	if (Object.isExtensible(value)) def(value, "__v_skip", true);
	return value;
}
var toReactive = (value) => isObject(value) ? reactive(value) : value;
var toReadonly = (value) => isObject(value) ? readonly(value) : value;
var ComputedRefImpl = class {
	constructor(getter, _setter, isReadonly, isSSR) {
		this.getter = getter;
		this._setter = _setter;
		this.dep = void 0;
		this.__v_isRef = true;
		this["__v_isReadonly"] = false;
		this.effect = new ReactiveEffect(() => getter(this._value), () => triggerRefValue(this, this.effect._dirtyLevel === 3 ? 3 : 4));
		this.effect.computed = this;
		this.effect.active = this._cacheable = !isSSR;
		this["__v_isReadonly"] = isReadonly;
	}
	get value() {
		const self = toRaw(this);
		if ((!self._cacheable || self.effect.dirty) && hasChanged(self._value, self._value = self.effect.run())) triggerRefValue(self, 5);
		trackRefValue(self);
		if (self.effect._dirtyLevel >= 2) triggerRefValue(self, 3);
		return self._value;
	}
	set value(newValue) {
		this._setter(newValue);
	}
	get _dirty() {
		return this.effect.dirty;
	}
	set _dirty(v) {
		this.effect.dirty = v;
	}
};
function computed$1(getterOrOptions, debugOptions, isSSR = false) {
	let getter;
	let setter;
	const onlyGetter = isFunction(getterOrOptions);
	if (onlyGetter) {
		getter = getterOrOptions;
		setter = NOOP;
	} else {
		getter = getterOrOptions.get;
		setter = getterOrOptions.set;
	}
	return new ComputedRefImpl(getter, setter, onlyGetter || !setter, isSSR);
}
function trackRefValue(ref2) {
	var _a;
	if (shouldTrack && activeEffect) {
		ref2 = toRaw(ref2);
		trackEffect(activeEffect, (_a = ref2.dep) != null ? _a : ref2.dep = createDep(() => ref2.dep = void 0, ref2 instanceof ComputedRefImpl ? ref2 : void 0), void 0);
	}
}
function triggerRefValue(ref2, dirtyLevel = 5, newVal, oldVal) {
	ref2 = toRaw(ref2);
	const dep = ref2.dep;
	if (dep) triggerEffects(dep, dirtyLevel, void 0);
}
function isRef(r) {
	return !!(r && r.__v_isRef === true);
}
function ref(value) {
	return createRef(value, false);
}
function shallowRef(value) {
	return createRef(value, true);
}
function createRef(rawValue, shallow) {
	if (isRef(rawValue)) return rawValue;
	return new RefImpl(rawValue, shallow);
}
var RefImpl = class {
	constructor(value, __v_isShallow) {
		this.__v_isShallow = __v_isShallow;
		this.dep = void 0;
		this.__v_isRef = true;
		this._rawValue = __v_isShallow ? value : toRaw(value);
		this._value = __v_isShallow ? value : toReactive(value);
	}
	get value() {
		trackRefValue(this);
		return this._value;
	}
	set value(newVal) {
		const useDirectValue = this.__v_isShallow || isShallow(newVal) || isReadonly(newVal);
		newVal = useDirectValue ? newVal : toRaw(newVal);
		if (hasChanged(newVal, this._rawValue)) {
			const oldVal = this._rawValue;
			this._rawValue = newVal;
			this._value = useDirectValue ? newVal : toReactive(newVal);
			triggerRefValue(this, 5, newVal, oldVal);
		}
	}
};
function triggerRef(ref2) {
	triggerRefValue(ref2, 5, void 0);
}
function unref(ref2) {
	return isRef(ref2) ? ref2.value : ref2;
}
function toValue(source) {
	return isFunction(source) ? source() : unref(source);
}
var shallowUnwrapHandlers = {
	get: (target, key, receiver) => unref(Reflect.get(target, key, receiver)),
	set: (target, key, value, receiver) => {
		const oldValue = target[key];
		if (isRef(oldValue) && !isRef(value)) {
			oldValue.value = value;
			return true;
		} else return Reflect.set(target, key, value, receiver);
	}
};
function proxyRefs(objectWithRefs) {
	return isReactive(objectWithRefs) ? objectWithRefs : new Proxy(objectWithRefs, shallowUnwrapHandlers);
}
var CustomRefImpl = class {
	constructor(factory) {
		this.dep = void 0;
		this.__v_isRef = true;
		const { get, set } = factory(() => trackRefValue(this), () => triggerRefValue(this));
		this._get = get;
		this._set = set;
	}
	get value() {
		return this._get();
	}
	set value(newVal) {
		this._set(newVal);
	}
};
function customRef(factory) {
	return new CustomRefImpl(factory);
}
function toRefs(object) {
	const ret = isArray$1(object) ? new Array(object.length) : {};
	for (const key in object) ret[key] = propertyToRef(object, key);
	return ret;
}
var ObjectRefImpl = class {
	constructor(_object, _key, _defaultValue) {
		this._object = _object;
		this._key = _key;
		this._defaultValue = _defaultValue;
		this.__v_isRef = true;
	}
	get value() {
		const val = this._object[this._key];
		return val === void 0 ? this._defaultValue : val;
	}
	set value(newVal) {
		this._object[this._key] = newVal;
	}
	get dep() {
		return getDepFromReactive(toRaw(this._object), this._key);
	}
};
var GetterRefImpl = class {
	constructor(_getter) {
		this._getter = _getter;
		this.__v_isRef = true;
		this.__v_isReadonly = true;
	}
	get value() {
		return this._getter();
	}
};
function toRef(source, key, defaultValue) {
	if (isRef(source)) return source;
	else if (isFunction(source)) return new GetterRefImpl(source);
	else if (isObject(source) && arguments.length > 1) return propertyToRef(source, key, defaultValue);
	else return ref(source);
}
function propertyToRef(source, key, defaultValue) {
	const val = source[key];
	return isRef(val) ? val : new ObjectRefImpl(source, key, defaultValue);
}
var TrackOpTypes = {
	"GET": "get",
	"HAS": "has",
	"ITERATE": "iterate"
};
var TriggerOpTypes = {
	"SET": "set",
	"ADD": "add",
	"DELETE": "delete",
	"CLEAR": "clear"
};
//#endregion
//#region node_modules/@vue/runtime-core/dist/runtime-core.esm-bundler.js
/**
* @vue/runtime-core v3.4.29
* (c) 2018-present Yuxi (Evan) You and Vue contributors
* @license MIT
**/
function assertNumber(val, type) {}
var ErrorCodes = {
	"SETUP_FUNCTION": 0,
	"0": "SETUP_FUNCTION",
	"RENDER_FUNCTION": 1,
	"1": "RENDER_FUNCTION",
	"WATCH_GETTER": 2,
	"2": "WATCH_GETTER",
	"WATCH_CALLBACK": 3,
	"3": "WATCH_CALLBACK",
	"WATCH_CLEANUP": 4,
	"4": "WATCH_CLEANUP",
	"NATIVE_EVENT_HANDLER": 5,
	"5": "NATIVE_EVENT_HANDLER",
	"COMPONENT_EVENT_HANDLER": 6,
	"6": "COMPONENT_EVENT_HANDLER",
	"VNODE_HOOK": 7,
	"7": "VNODE_HOOK",
	"DIRECTIVE_HOOK": 8,
	"8": "DIRECTIVE_HOOK",
	"TRANSITION_HOOK": 9,
	"9": "TRANSITION_HOOK",
	"APP_ERROR_HANDLER": 10,
	"10": "APP_ERROR_HANDLER",
	"APP_WARN_HANDLER": 11,
	"11": "APP_WARN_HANDLER",
	"FUNCTION_REF": 12,
	"12": "FUNCTION_REF",
	"ASYNC_COMPONENT_LOADER": 13,
	"13": "ASYNC_COMPONENT_LOADER",
	"SCHEDULER": 14,
	"14": "SCHEDULER"
};
var ErrorTypeStrings$1 = {
	["sp"]: "serverPrefetch hook",
	["bc"]: "beforeCreate hook",
	["c"]: "created hook",
	["bm"]: "beforeMount hook",
	["m"]: "mounted hook",
	["bu"]: "beforeUpdate hook",
	["u"]: "updated",
	["bum"]: "beforeUnmount hook",
	["um"]: "unmounted hook",
	["a"]: "activated hook",
	["da"]: "deactivated hook",
	["ec"]: "errorCaptured hook",
	["rtc"]: "renderTracked hook",
	["rtg"]: "renderTriggered hook",
	[0]: "setup function",
	[1]: "render function",
	[2]: "watcher getter",
	[3]: "watcher callback",
	[4]: "watcher cleanup function",
	[5]: "native event handler",
	[6]: "component event handler",
	[7]: "vnode hook",
	[8]: "directive hook",
	[9]: "transition hook",
	[10]: "app errorHandler",
	[11]: "app warnHandler",
	[12]: "ref function",
	[13]: "async component loader",
	[14]: "scheduler flush. This is likely a Vue internals bug. Please open an issue at https://github.com/vuejs/core ."
};
function callWithErrorHandling(fn, instance, type, args) {
	try {
		return args ? fn(...args) : fn();
	} catch (err) {
		handleError(err, instance, type);
	}
}
function callWithAsyncErrorHandling(fn, instance, type, args) {
	if (isFunction(fn)) {
		const res = callWithErrorHandling(fn, instance, type, args);
		if (res && isPromise(res)) res.catch((err) => {
			handleError(err, instance, type);
		});
		return res;
	}
	if (isArray$1(fn)) {
		const values = [];
		for (let i = 0; i < fn.length; i++) values.push(callWithAsyncErrorHandling(fn[i], instance, type, args));
		return values;
	}
}
function handleError(err, instance, type, throwInDev = true) {
	const contextVNode = instance ? instance.vnode : null;
	if (instance) {
		let cur = instance.parent;
		const exposedInstance = instance.proxy;
		const errorInfo = `https://vuejs.org/error-reference/#runtime-${type}`;
		while (cur) {
			const errorCapturedHooks = cur.ec;
			if (errorCapturedHooks) {
				for (let i = 0; i < errorCapturedHooks.length; i++) if (errorCapturedHooks[i](err, exposedInstance, errorInfo) === false) return;
			}
			cur = cur.parent;
		}
		const appErrorHandler = instance.appContext.config.errorHandler;
		if (appErrorHandler) {
			pauseTracking();
			callWithErrorHandling(appErrorHandler, null, 10, [
				err,
				exposedInstance,
				errorInfo
			]);
			resetTracking();
			return;
		}
	}
	logError(err, type, contextVNode, throwInDev);
}
function logError(err, type, contextVNode, throwInDev = true) {
	console.error(err);
}
var isFlushing = false;
var isFlushPending = false;
var queue = [];
var flushIndex = 0;
var pendingPostFlushCbs = [];
var activePostFlushCbs = null;
var postFlushIndex = 0;
var resolvedPromise = /* @__PURE__ */ Promise.resolve();
var currentFlushPromise = null;
function nextTick(fn) {
	const p = currentFlushPromise || resolvedPromise;
	return fn ? p.then(this ? fn.bind(this) : fn) : p;
}
function findInsertionIndex$1(id) {
	let start = flushIndex + 1;
	let end = queue.length;
	while (start < end) {
		const middle = start + end >>> 1;
		const middleJob = queue[middle];
		const middleJobId = getId(middleJob);
		if (middleJobId < id || middleJobId === id && middleJob.pre) start = middle + 1;
		else end = middle;
	}
	return start;
}
function queueJob(job) {
	if (!queue.length || !queue.includes(job, isFlushing && job.allowRecurse ? flushIndex + 1 : flushIndex)) {
		if (job.id == null) queue.push(job);
		else queue.splice(findInsertionIndex$1(job.id), 0, job);
		queueFlush();
	}
}
function queueFlush() {
	if (!isFlushing && !isFlushPending) {
		isFlushPending = true;
		currentFlushPromise = resolvedPromise.then(flushJobs);
	}
}
function invalidateJob(job) {
	const i = queue.indexOf(job);
	if (i > flushIndex) queue.splice(i, 1);
}
function queuePostFlushCb(cb) {
	if (!isArray$1(cb)) {
		if (!activePostFlushCbs || !activePostFlushCbs.includes(cb, cb.allowRecurse ? postFlushIndex + 1 : postFlushIndex)) pendingPostFlushCbs.push(cb);
	} else pendingPostFlushCbs.push(...cb);
	queueFlush();
}
function flushPreFlushCbs(instance, seen, i = isFlushing ? flushIndex + 1 : 0) {
	for (; i < queue.length; i++) {
		const cb = queue[i];
		if (cb && cb.pre) {
			if (instance && cb.id !== instance.uid) continue;
			queue.splice(i, 1);
			i--;
			cb();
		}
	}
}
function flushPostFlushCbs(seen) {
	if (pendingPostFlushCbs.length) {
		const deduped = [...new Set(pendingPostFlushCbs)].sort((a, b) => getId(a) - getId(b));
		pendingPostFlushCbs.length = 0;
		if (activePostFlushCbs) {
			activePostFlushCbs.push(...deduped);
			return;
		}
		activePostFlushCbs = deduped;
		for (postFlushIndex = 0; postFlushIndex < activePostFlushCbs.length; postFlushIndex++) {
			const cb = activePostFlushCbs[postFlushIndex];
			if (cb.active !== false) cb();
		}
		activePostFlushCbs = null;
		postFlushIndex = 0;
	}
}
var getId = (job) => job.id == null ? Infinity : job.id;
var comparator = (a, b) => {
	const diff = getId(a) - getId(b);
	if (diff === 0) {
		if (a.pre && !b.pre) return -1;
		if (b.pre && !a.pre) return 1;
	}
	return diff;
};
function flushJobs(seen) {
	isFlushPending = false;
	isFlushing = true;
	queue.sort(comparator);
	try {
		for (flushIndex = 0; flushIndex < queue.length; flushIndex++) {
			const job = queue[flushIndex];
			if (job && job.active !== false) callWithErrorHandling(job, null, 14);
		}
	} finally {
		flushIndex = 0;
		queue.length = 0;
		flushPostFlushCbs(seen);
		isFlushing = false;
		currentFlushPromise = null;
		if (queue.length || pendingPostFlushCbs.length) flushJobs(seen);
	}
}
var devtools$1;
var buffer = [];
function setDevtoolsHook$1(hook, target) {
	var _a, _b;
	devtools$1 = hook;
	if (devtools$1) {
		devtools$1.enabled = true;
		buffer.forEach(({ event, args }) => devtools$1.emit(event, ...args));
		buffer = [];
	} else if (typeof window !== "undefined" && window.HTMLElement && !((_b = (_a = window.navigator) == null ? void 0 : _a.userAgent) == null ? void 0 : _b.includes("jsdom"))) {
		(target.__VUE_DEVTOOLS_HOOK_REPLAY__ = target.__VUE_DEVTOOLS_HOOK_REPLAY__ || []).push((newHook) => {
			setDevtoolsHook$1(newHook, target);
		});
		setTimeout(() => {
			if (!devtools$1) {
				target.__VUE_DEVTOOLS_HOOK_REPLAY__ = null;
				buffer = [];
			}
		}, 3e3);
	} else buffer = [];
}
function emit(instance, event, ...rawArgs) {
	if (instance.isUnmounted) return;
	const props = instance.vnode.props || EMPTY_OBJ;
	let args = rawArgs;
	const isModelListener = event.startsWith("update:");
	const modelArg = isModelListener && event.slice(7);
	if (modelArg && modelArg in props) {
		const { number, trim } = props[`${modelArg === "modelValue" ? "model" : modelArg}Modifiers`] || EMPTY_OBJ;
		if (trim) args = rawArgs.map((a) => isString(a) ? a.trim() : a);
		if (number) args = rawArgs.map(looseToNumber);
	}
	let handlerName;
	let handler = props[handlerName = toHandlerKey(event)] || props[handlerName = toHandlerKey(camelize(event))];
	if (!handler && isModelListener) handler = props[handlerName = toHandlerKey(hyphenate(event))];
	if (handler) callWithAsyncErrorHandling(handler, instance, 6, args);
	const onceHandler = props[handlerName + `Once`];
	if (onceHandler) {
		if (!instance.emitted) instance.emitted = {};
		else if (instance.emitted[handlerName]) return;
		instance.emitted[handlerName] = true;
		callWithAsyncErrorHandling(onceHandler, instance, 6, args);
	}
}
function normalizeEmitsOptions(comp, appContext, asMixin = false) {
	const cache = appContext.emitsCache;
	const cached = cache.get(comp);
	if (cached !== void 0) return cached;
	const raw = comp.emits;
	let normalized = {};
	let hasExtends = false;
	if (!isFunction(comp)) {
		const extendEmits = (raw2) => {
			const normalizedFromExtend = normalizeEmitsOptions(raw2, appContext, true);
			if (normalizedFromExtend) {
				hasExtends = true;
				extend(normalized, normalizedFromExtend);
			}
		};
		if (!asMixin && appContext.mixins.length) appContext.mixins.forEach(extendEmits);
		if (comp.extends) extendEmits(comp.extends);
		if (comp.mixins) comp.mixins.forEach(extendEmits);
	}
	if (!raw && !hasExtends) {
		if (isObject(comp)) cache.set(comp, null);
		return null;
	}
	if (isArray$1(raw)) raw.forEach((key) => normalized[key] = null);
	else extend(normalized, raw);
	if (isObject(comp)) cache.set(comp, normalized);
	return normalized;
}
function isEmitListener(options, key) {
	if (!options || !isOn(key)) return false;
	key = key.slice(2).replace(/Once$/, "");
	return hasOwn(options, key[0].toLowerCase() + key.slice(1)) || hasOwn(options, hyphenate(key)) || hasOwn(options, key);
}
var currentRenderingInstance = null;
var currentScopeId = null;
function setCurrentRenderingInstance(instance) {
	const prev = currentRenderingInstance;
	currentRenderingInstance = instance;
	currentScopeId = instance && instance.type.__scopeId || null;
	return prev;
}
function pushScopeId(id) {
	currentScopeId = id;
}
function popScopeId() {
	currentScopeId = null;
}
var withScopeId = (_id) => withCtx;
function withCtx(fn, ctx = currentRenderingInstance, isNonScopedSlot) {
	if (!ctx) return fn;
	if (fn._n) return fn;
	const renderFnWithContext = (...args) => {
		if (renderFnWithContext._d) setBlockTracking(-1);
		const prevInstance = setCurrentRenderingInstance(ctx);
		let res;
		try {
			res = fn(...args);
		} finally {
			setCurrentRenderingInstance(prevInstance);
			if (renderFnWithContext._d) setBlockTracking(1);
		}
		return res;
	};
	renderFnWithContext._n = true;
	renderFnWithContext._c = true;
	renderFnWithContext._d = true;
	return renderFnWithContext;
}
function renderComponentRoot(instance) {
	const { type: Component, vnode, proxy, withProxy, propsOptions: [propsOptions], slots, attrs, emit, render, renderCache, props, data, setupState, ctx, inheritAttrs } = instance;
	const prev = setCurrentRenderingInstance(instance);
	let result;
	let fallthroughAttrs;
	try {
		if (vnode.shapeFlag & 4) {
			const proxyToUse = withProxy || proxy;
			const thisProxy = proxyToUse;
			result = normalizeVNode(render.call(thisProxy, proxyToUse, renderCache, props, setupState, data, ctx));
			fallthroughAttrs = attrs;
		} else {
			const render2 = Component;
			result = normalizeVNode(render2.length > 1 ? render2(props, {
				attrs,
				slots,
				emit
			}) : render2(props, null));
			fallthroughAttrs = Component.props ? attrs : getFunctionalFallthrough(attrs);
		}
	} catch (err) {
		blockStack.length = 0;
		handleError(err, instance, 1);
		result = createVNode(Comment);
	}
	let root = result;
	if (fallthroughAttrs && inheritAttrs !== false) {
		const keys = Object.keys(fallthroughAttrs);
		const { shapeFlag } = root;
		if (keys.length) {
			if (shapeFlag & 7) {
				if (propsOptions && keys.some(isModelListener)) fallthroughAttrs = filterModelListeners(fallthroughAttrs, propsOptions);
				root = cloneVNode(root, fallthroughAttrs, false, true);
			}
		}
	}
	if (vnode.dirs) {
		root = cloneVNode(root, null, false, true);
		root.dirs = root.dirs ? root.dirs.concat(vnode.dirs) : vnode.dirs;
	}
	if (vnode.transition) root.transition = vnode.transition;
	result = root;
	setCurrentRenderingInstance(prev);
	return result;
}
function filterSingleRoot(children, recurse = true) {
	let singleRoot;
	for (let i = 0; i < children.length; i++) {
		const child = children[i];
		if (isVNode(child)) {
			if (child.type !== Comment || child.children === "v-if") if (singleRoot) return;
			else singleRoot = child;
		} else return;
	}
	return singleRoot;
}
var getFunctionalFallthrough = (attrs) => {
	let res;
	for (const key in attrs) if (key === "class" || key === "style" || isOn(key)) (res || (res = {}))[key] = attrs[key];
	return res;
};
var filterModelListeners = (attrs, props) => {
	const res = {};
	for (const key in attrs) if (!isModelListener(key) || !(key.slice(9) in props)) res[key] = attrs[key];
	return res;
};
function shouldUpdateComponent(prevVNode, nextVNode, optimized) {
	const { props: prevProps, children: prevChildren, component } = prevVNode;
	const { props: nextProps, children: nextChildren, patchFlag } = nextVNode;
	const emits = component.emitsOptions;
	if (nextVNode.dirs || nextVNode.transition) return true;
	if (optimized && patchFlag >= 0) {
		if (patchFlag & 1024) return true;
		if (patchFlag & 16) {
			if (!prevProps) return !!nextProps;
			return hasPropsChanged(prevProps, nextProps, emits);
		} else if (patchFlag & 8) {
			const dynamicProps = nextVNode.dynamicProps;
			for (let i = 0; i < dynamicProps.length; i++) {
				const key = dynamicProps[i];
				if (nextProps[key] !== prevProps[key] && !isEmitListener(emits, key)) return true;
			}
		}
	} else {
		if (prevChildren || nextChildren) {
			if (!nextChildren || !nextChildren.$stable) return true;
		}
		if (prevProps === nextProps) return false;
		if (!prevProps) return !!nextProps;
		if (!nextProps) return true;
		return hasPropsChanged(prevProps, nextProps, emits);
	}
	return false;
}
function hasPropsChanged(prevProps, nextProps, emitsOptions) {
	const nextKeys = Object.keys(nextProps);
	if (nextKeys.length !== Object.keys(prevProps).length) return true;
	for (let i = 0; i < nextKeys.length; i++) {
		const key = nextKeys[i];
		if (nextProps[key] !== prevProps[key] && !isEmitListener(emitsOptions, key)) return true;
	}
	return false;
}
function updateHOCHostEl({ vnode, parent }, el) {
	while (parent) {
		const root = parent.subTree;
		if (root.suspense && root.suspense.activeBranch === vnode) root.el = vnode.el;
		if (root === vnode) {
			(vnode = parent.vnode).el = el;
			parent = parent.parent;
		} else break;
	}
}
var COMPONENTS = "components";
var DIRECTIVES = "directives";
function resolveComponent(name, maybeSelfReference) {
	return resolveAsset(COMPONENTS, name, true, maybeSelfReference) || name;
}
var NULL_DYNAMIC_COMPONENT = Symbol.for("v-ndc");
function resolveDynamicComponent(component) {
	if (isString(component)) return resolveAsset(COMPONENTS, component, false) || component;
	else return component || NULL_DYNAMIC_COMPONENT;
}
function resolveDirective(name) {
	return resolveAsset(DIRECTIVES, name);
}
function resolveAsset(type, name, warnMissing = true, maybeSelfReference = false) {
	const instance = currentRenderingInstance || currentInstance;
	if (instance) {
		const Component = instance.type;
		if (type === COMPONENTS) {
			const selfName = getComponentName(Component, false);
			if (selfName && (selfName === name || selfName === camelize(name) || selfName === capitalize(camelize(name)))) return Component;
		}
		const res = resolve(instance[type] || Component[type], name) || resolve(instance.appContext[type], name);
		if (!res && maybeSelfReference) return Component;
		return res;
	}
}
function resolve(registry, name) {
	return registry && (registry[name] || registry[camelize(name)] || registry[capitalize(camelize(name))]);
}
var isSuspense = (type) => type.__isSuspense;
var suspenseId = 0;
var Suspense = {
	name: "Suspense",
	__isSuspense: true,
	process(n1, n2, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized, rendererInternals) {
		if (n1 == null) mountSuspense(n2, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized, rendererInternals);
		else {
			if (parentSuspense && parentSuspense.deps > 0 && !n1.suspense.isInFallback) {
				n2.suspense = n1.suspense;
				n2.suspense.vnode = n2;
				n2.el = n1.el;
				return;
			}
			patchSuspense(n1, n2, container, anchor, parentComponent, namespace, slotScopeIds, optimized, rendererInternals);
		}
	},
	hydrate: hydrateSuspense,
	create: createSuspenseBoundary,
	normalize: normalizeSuspenseChildren
};
function triggerEvent(vnode, name) {
	const eventListener = vnode.props && vnode.props[name];
	if (isFunction(eventListener)) eventListener();
}
function mountSuspense(vnode, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized, rendererInternals) {
	const { p: patch, o: { createElement } } = rendererInternals;
	const hiddenContainer = createElement("div");
	const suspense = vnode.suspense = createSuspenseBoundary(vnode, parentSuspense, parentComponent, container, hiddenContainer, anchor, namespace, slotScopeIds, optimized, rendererInternals);
	patch(null, suspense.pendingBranch = vnode.ssContent, hiddenContainer, null, parentComponent, suspense, namespace, slotScopeIds);
	if (suspense.deps > 0) {
		triggerEvent(vnode, "onPending");
		triggerEvent(vnode, "onFallback");
		patch(null, vnode.ssFallback, container, anchor, parentComponent, null, namespace, slotScopeIds);
		setActiveBranch(suspense, vnode.ssFallback);
	} else suspense.resolve(false, true);
}
function patchSuspense(n1, n2, container, anchor, parentComponent, namespace, slotScopeIds, optimized, { p: patch, um: unmount, o: { createElement } }) {
	const suspense = n2.suspense = n1.suspense;
	suspense.vnode = n2;
	n2.el = n1.el;
	const newBranch = n2.ssContent;
	const newFallback = n2.ssFallback;
	const { activeBranch, pendingBranch, isInFallback, isHydrating } = suspense;
	if (pendingBranch) {
		suspense.pendingBranch = newBranch;
		if (isSameVNodeType(newBranch, pendingBranch)) {
			patch(pendingBranch, newBranch, suspense.hiddenContainer, null, parentComponent, suspense, namespace, slotScopeIds, optimized);
			if (suspense.deps <= 0) suspense.resolve();
			else if (isInFallback) {
				if (!isHydrating) {
					patch(activeBranch, newFallback, container, anchor, parentComponent, null, namespace, slotScopeIds, optimized);
					setActiveBranch(suspense, newFallback);
				}
			}
		} else {
			suspense.pendingId = suspenseId++;
			if (isHydrating) {
				suspense.isHydrating = false;
				suspense.activeBranch = pendingBranch;
			} else unmount(pendingBranch, parentComponent, suspense);
			suspense.deps = 0;
			suspense.effects.length = 0;
			suspense.hiddenContainer = createElement("div");
			if (isInFallback) {
				patch(null, newBranch, suspense.hiddenContainer, null, parentComponent, suspense, namespace, slotScopeIds, optimized);
				if (suspense.deps <= 0) suspense.resolve();
				else {
					patch(activeBranch, newFallback, container, anchor, parentComponent, null, namespace, slotScopeIds, optimized);
					setActiveBranch(suspense, newFallback);
				}
			} else if (activeBranch && isSameVNodeType(newBranch, activeBranch)) {
				patch(activeBranch, newBranch, container, anchor, parentComponent, suspense, namespace, slotScopeIds, optimized);
				suspense.resolve(true);
			} else {
				patch(null, newBranch, suspense.hiddenContainer, null, parentComponent, suspense, namespace, slotScopeIds, optimized);
				if (suspense.deps <= 0) suspense.resolve();
			}
		}
	} else if (activeBranch && isSameVNodeType(newBranch, activeBranch)) {
		patch(activeBranch, newBranch, container, anchor, parentComponent, suspense, namespace, slotScopeIds, optimized);
		setActiveBranch(suspense, newBranch);
	} else {
		triggerEvent(n2, "onPending");
		suspense.pendingBranch = newBranch;
		if (newBranch.shapeFlag & 512) suspense.pendingId = newBranch.component.suspenseId;
		else suspense.pendingId = suspenseId++;
		patch(null, newBranch, suspense.hiddenContainer, null, parentComponent, suspense, namespace, slotScopeIds, optimized);
		if (suspense.deps <= 0) suspense.resolve();
		else {
			const { timeout, pendingId } = suspense;
			if (timeout > 0) setTimeout(() => {
				if (suspense.pendingId === pendingId) suspense.fallback(newFallback);
			}, timeout);
			else if (timeout === 0) suspense.fallback(newFallback);
		}
	}
}
function createSuspenseBoundary(vnode, parentSuspense, parentComponent, container, hiddenContainer, anchor, namespace, slotScopeIds, optimized, rendererInternals, isHydrating = false) {
	const { p: patch, m: move, um: unmount, n: next, o: { parentNode, remove } } = rendererInternals;
	let parentSuspenseId;
	const isSuspensible = isVNodeSuspensible(vnode);
	if (isSuspensible) {
		if (parentSuspense && parentSuspense.pendingBranch) {
			parentSuspenseId = parentSuspense.pendingId;
			parentSuspense.deps++;
		}
	}
	const timeout = vnode.props ? toNumber(vnode.props.timeout) : void 0;
	const initialAnchor = anchor;
	const suspense = {
		vnode,
		parent: parentSuspense,
		parentComponent,
		namespace,
		container,
		hiddenContainer,
		deps: 0,
		pendingId: suspenseId++,
		timeout: typeof timeout === "number" ? timeout : -1,
		activeBranch: null,
		pendingBranch: null,
		isInFallback: !isHydrating,
		isHydrating,
		isUnmounted: false,
		effects: [],
		resolve(resume = false, sync = false) {
			const { vnode: vnode2, activeBranch, pendingBranch, pendingId, effects, parentComponent: parentComponent2, container: container2 } = suspense;
			let delayEnter = false;
			if (suspense.isHydrating) suspense.isHydrating = false;
			else if (!resume) {
				delayEnter = activeBranch && pendingBranch.transition && pendingBranch.transition.mode === "out-in";
				if (delayEnter) activeBranch.transition.afterLeave = () => {
					if (pendingId === suspense.pendingId) {
						move(pendingBranch, container2, anchor === initialAnchor ? next(activeBranch) : anchor, 0);
						queuePostFlushCb(effects);
					}
				};
				if (activeBranch) {
					if (parentNode(activeBranch.el) !== suspense.hiddenContainer) anchor = next(activeBranch);
					unmount(activeBranch, parentComponent2, suspense, true);
				}
				if (!delayEnter) move(pendingBranch, container2, anchor, 0);
			}
			setActiveBranch(suspense, pendingBranch);
			suspense.pendingBranch = null;
			suspense.isInFallback = false;
			let parent = suspense.parent;
			let hasUnresolvedAncestor = false;
			while (parent) {
				if (parent.pendingBranch) {
					parent.effects.push(...effects);
					hasUnresolvedAncestor = true;
					break;
				}
				parent = parent.parent;
			}
			if (!hasUnresolvedAncestor && !delayEnter) queuePostFlushCb(effects);
			suspense.effects = [];
			if (isSuspensible) {
				if (parentSuspense && parentSuspense.pendingBranch && parentSuspenseId === parentSuspense.pendingId) {
					parentSuspense.deps--;
					if (parentSuspense.deps === 0 && !sync) parentSuspense.resolve();
				}
			}
			triggerEvent(vnode2, "onResolve");
		},
		fallback(fallbackVNode) {
			if (!suspense.pendingBranch) return;
			const { vnode: vnode2, activeBranch, parentComponent: parentComponent2, container: container2, namespace: namespace2 } = suspense;
			triggerEvent(vnode2, "onFallback");
			const anchor2 = next(activeBranch);
			const mountFallback = () => {
				if (!suspense.isInFallback) return;
				patch(null, fallbackVNode, container2, anchor2, parentComponent2, null, namespace2, slotScopeIds, optimized);
				setActiveBranch(suspense, fallbackVNode);
			};
			const delayEnter = fallbackVNode.transition && fallbackVNode.transition.mode === "out-in";
			if (delayEnter) activeBranch.transition.afterLeave = mountFallback;
			suspense.isInFallback = true;
			unmount(activeBranch, parentComponent2, null, true);
			if (!delayEnter) mountFallback();
		},
		move(container2, anchor2, type) {
			suspense.activeBranch && move(suspense.activeBranch, container2, anchor2, type);
			suspense.container = container2;
		},
		next() {
			return suspense.activeBranch && next(suspense.activeBranch);
		},
		registerDep(instance, setupRenderEffect, optimized2) {
			const isInPendingSuspense = !!suspense.pendingBranch;
			if (isInPendingSuspense) suspense.deps++;
			const hydratedEl = instance.vnode.el;
			instance.asyncDep.catch((err) => {
				handleError(err, instance, 0);
			}).then((asyncSetupResult) => {
				if (instance.isUnmounted || suspense.isUnmounted || suspense.pendingId !== instance.suspenseId) return;
				instance.asyncResolved = true;
				const { vnode: vnode2 } = instance;
				handleSetupResult(instance, asyncSetupResult, false);
				if (hydratedEl) vnode2.el = hydratedEl;
				const placeholder = !hydratedEl && instance.subTree.el;
				setupRenderEffect(instance, vnode2, parentNode(hydratedEl || instance.subTree.el), hydratedEl ? null : next(instance.subTree), suspense, namespace, optimized2);
				if (placeholder) remove(placeholder);
				updateHOCHostEl(instance, vnode2.el);
				if (isInPendingSuspense && --suspense.deps === 0) suspense.resolve();
			});
		},
		unmount(parentSuspense2, doRemove) {
			suspense.isUnmounted = true;
			if (suspense.activeBranch) unmount(suspense.activeBranch, parentComponent, parentSuspense2, doRemove);
			if (suspense.pendingBranch) unmount(suspense.pendingBranch, parentComponent, parentSuspense2, doRemove);
		}
	};
	return suspense;
}
function hydrateSuspense(node, vnode, parentComponent, parentSuspense, namespace, slotScopeIds, optimized, rendererInternals, hydrateNode) {
	const suspense = vnode.suspense = createSuspenseBoundary(vnode, parentSuspense, parentComponent, node.parentNode, document.createElement("div"), null, namespace, slotScopeIds, optimized, rendererInternals, true);
	const result = hydrateNode(node, suspense.pendingBranch = vnode.ssContent, parentComponent, suspense, slotScopeIds, optimized);
	if (suspense.deps === 0) suspense.resolve(false, true);
	return result;
}
function normalizeSuspenseChildren(vnode) {
	const { shapeFlag, children } = vnode;
	const isSlotChildren = shapeFlag & 32;
	vnode.ssContent = normalizeSuspenseSlot(isSlotChildren ? children.default : children);
	vnode.ssFallback = isSlotChildren ? normalizeSuspenseSlot(children.fallback) : createVNode(Comment);
}
function normalizeSuspenseSlot(s) {
	let block;
	if (isFunction(s)) {
		const trackBlock = isBlockTreeEnabled && s._c;
		if (trackBlock) {
			s._d = false;
			openBlock();
		}
		s = s();
		if (trackBlock) {
			s._d = true;
			block = currentBlock;
			closeBlock();
		}
	}
	if (isArray$1(s)) s = filterSingleRoot(s);
	s = normalizeVNode(s);
	if (block && !s.dynamicChildren) s.dynamicChildren = block.filter((c) => c !== s);
	return s;
}
function queueEffectWithSuspense(fn, suspense) {
	if (suspense && suspense.pendingBranch) if (isArray$1(fn)) suspense.effects.push(...fn);
	else suspense.effects.push(fn);
	else queuePostFlushCb(fn);
}
function setActiveBranch(suspense, branch) {
	suspense.activeBranch = branch;
	const { vnode, parentComponent } = suspense;
	let el = branch.el;
	while (!el && branch.component) {
		branch = branch.component.subTree;
		el = branch.el;
	}
	vnode.el = el;
	if (parentComponent && parentComponent.subTree === vnode) {
		parentComponent.vnode.el = el;
		updateHOCHostEl(parentComponent, el);
	}
}
function isVNodeSuspensible(vnode) {
	const suspensible = vnode.props && vnode.props.suspensible;
	return suspensible != null && suspensible !== false;
}
function injectHook(type, hook, target = currentInstance, prepend = false) {
	if (target) {
		const hooks = target[type] || (target[type] = []);
		const wrappedHook = hook.__weh || (hook.__weh = (...args) => {
			pauseTracking();
			const reset = setCurrentInstance(target);
			const res = callWithAsyncErrorHandling(hook, target, type, args);
			reset();
			resetTracking();
			return res;
		});
		if (prepend) hooks.unshift(wrappedHook);
		else hooks.push(wrappedHook);
		return wrappedHook;
	}
}
var createHook = (lifecycle) => (hook, target = currentInstance) => {
	if (!isInSSRComponentSetup || lifecycle === "sp") injectHook(lifecycle, (...args) => hook(...args), target);
};
var onBeforeMount = createHook("bm");
var onMounted = createHook("m");
var onBeforeUpdate = createHook("bu");
var onUpdated = createHook("u");
var onBeforeUnmount = createHook("bum");
var onUnmounted = createHook("um");
var onServerPrefetch = createHook("sp");
var onRenderTriggered = createHook("rtg");
var onRenderTracked = createHook("rtc");
function onErrorCaptured(hook, target = currentInstance) {
	injectHook("ec", hook, target);
}
function withDirectives(vnode, directives) {
	if (currentRenderingInstance === null) return vnode;
	const instance = getComponentPublicInstance(currentRenderingInstance);
	const bindings = vnode.dirs || (vnode.dirs = []);
	for (let i = 0; i < directives.length; i++) {
		let [dir, value, arg, modifiers = EMPTY_OBJ] = directives[i];
		if (dir) {
			if (isFunction(dir)) dir = {
				mounted: dir,
				updated: dir
			};
			if (dir.deep) traverse(value);
			bindings.push({
				dir,
				instance,
				value,
				oldValue: void 0,
				arg,
				modifiers
			});
		}
	}
	return vnode;
}
function invokeDirectiveHook(vnode, prevVNode, instance, name) {
	const bindings = vnode.dirs;
	const oldBindings = prevVNode && prevVNode.dirs;
	for (let i = 0; i < bindings.length; i++) {
		const binding = bindings[i];
		if (oldBindings) binding.oldValue = oldBindings[i].value;
		let hook = binding.dir[name];
		if (hook) {
			pauseTracking();
			callWithAsyncErrorHandling(hook, instance, 8, [
				vnode.el,
				binding,
				vnode,
				prevVNode
			]);
			resetTracking();
		}
	}
}
function renderList(source, renderItem, cache, index) {
	let ret;
	const cached = cache && cache[index];
	if (isArray$1(source) || isString(source)) {
		ret = new Array(source.length);
		for (let i = 0, l = source.length; i < l; i++) ret[i] = renderItem(source[i], i, void 0, cached && cached[i]);
	} else if (typeof source === "number") {
		ret = new Array(source);
		for (let i = 0; i < source; i++) ret[i] = renderItem(i + 1, i, void 0, cached && cached[i]);
	} else if (isObject(source)) if (source[Symbol.iterator]) ret = Array.from(source, (item, i) => renderItem(item, i, void 0, cached && cached[i]));
	else {
		const keys = Object.keys(source);
		ret = new Array(keys.length);
		for (let i = 0, l = keys.length; i < l; i++) {
			const key = keys[i];
			ret[i] = renderItem(source[key], key, i, cached && cached[i]);
		}
	}
	else ret = [];
	if (cache) cache[index] = ret;
	return ret;
}
function createSlots(slots, dynamicSlots) {
	for (let i = 0; i < dynamicSlots.length; i++) {
		const slot = dynamicSlots[i];
		if (isArray$1(slot)) for (let j = 0; j < slot.length; j++) slots[slot[j].name] = slot[j].fn;
		else if (slot) slots[slot.name] = slot.key ? (...args) => {
			const res = slot.fn(...args);
			if (res) res.key = slot.key;
			return res;
		} : slot.fn;
	}
	return slots;
}
/*! #__NO_SIDE_EFFECTS__ */
/* @__NO_SIDE_EFFECTS__ */
function defineComponent(options, extraOptions) {
	return isFunction(options) ? extend({ name: options.name }, extraOptions, { setup: options }) : options;
}
var isAsyncWrapper = (i) => !!i.type.__asyncLoader;
/*! #__NO_SIDE_EFFECTS__ */
/* @__NO_SIDE_EFFECTS__ */
function defineAsyncComponent(source) {
	if (isFunction(source)) source = { loader: source };
	const { loader, loadingComponent, errorComponent, delay = 200, timeout, suspensible = true, onError: userOnError } = source;
	let pendingRequest = null;
	let resolvedComp;
	let retries = 0;
	const retry = () => {
		retries++;
		pendingRequest = null;
		return load();
	};
	const load = () => {
		let thisRequest;
		return pendingRequest || (thisRequest = pendingRequest = loader().catch((err) => {
			err = err instanceof Error ? err : new Error(String(err));
			if (userOnError) return new Promise((resolve, reject) => {
				const userRetry = () => resolve(retry());
				const userFail = () => reject(err);
				userOnError(err, userRetry, userFail, retries + 1);
			});
			else throw err;
		}).then((comp) => {
			if (thisRequest !== pendingRequest && pendingRequest) return pendingRequest;
			if (comp && (comp.__esModule || comp[Symbol.toStringTag] === "Module")) comp = comp.default;
			resolvedComp = comp;
			return comp;
		}));
	};
	return /* @__PURE__ */ defineComponent({
		name: "AsyncComponentWrapper",
		__asyncLoader: load,
		get __asyncResolved() {
			return resolvedComp;
		},
		setup() {
			const instance = currentInstance;
			if (resolvedComp) return () => createInnerComp(resolvedComp, instance);
			const onError = (err) => {
				pendingRequest = null;
				handleError(err, instance, 13, !errorComponent);
			};
			if (suspensible && instance.suspense || isInSSRComponentSetup) return load().then((comp) => {
				return () => createInnerComp(comp, instance);
			}).catch((err) => {
				onError(err);
				return () => errorComponent ? createVNode(errorComponent, { error: err }) : null;
			});
			const loaded = ref(false);
			const error = ref();
			const delayed = ref(!!delay);
			if (delay) setTimeout(() => {
				delayed.value = false;
			}, delay);
			if (timeout != null) setTimeout(() => {
				if (!loaded.value && !error.value) {
					const err = /* @__PURE__ */ new Error(`Async component timed out after ${timeout}ms.`);
					onError(err);
					error.value = err;
				}
			}, timeout);
			load().then(() => {
				loaded.value = true;
				if (instance.parent && isKeepAlive(instance.parent.vnode)) {
					instance.parent.effect.dirty = true;
					queueJob(instance.parent.update);
				}
			}).catch((err) => {
				onError(err);
				error.value = err;
			});
			return () => {
				if (loaded.value && resolvedComp) return createInnerComp(resolvedComp, instance);
				else if (error.value && errorComponent) return createVNode(errorComponent, { error: error.value });
				else if (loadingComponent && !delayed.value) return createVNode(loadingComponent);
			};
		}
	});
}
function createInnerComp(comp, parent) {
	const { ref: ref2, props, children, ce } = parent.vnode;
	const vnode = createVNode(comp, props, children);
	vnode.ref = ref2;
	vnode.ce = ce;
	delete parent.vnode.ce;
	return vnode;
}
function renderSlot(slots, name, props = {}, fallback, noSlotted) {
	if (currentRenderingInstance.isCE || currentRenderingInstance.parent && isAsyncWrapper(currentRenderingInstance.parent) && currentRenderingInstance.parent.isCE) {
		if (name !== "default") props.name = name;
		return createVNode("slot", props, fallback && fallback());
	}
	let slot = slots[name];
	if (slot && slot._c) slot._d = false;
	openBlock();
	const validSlotContent = slot && ensureValidVNode(slot(props));
	const rendered = createBlock(Fragment, { key: props.key || validSlotContent && validSlotContent.key || `_${name}` }, validSlotContent || (fallback ? fallback() : []), validSlotContent && slots._ === 1 ? 64 : -2);
	if (!noSlotted && rendered.scopeId) rendered.slotScopeIds = [rendered.scopeId + "-s"];
	if (slot && slot._c) slot._d = true;
	return rendered;
}
function ensureValidVNode(vnodes) {
	return vnodes.some((child) => {
		if (!isVNode(child)) return true;
		if (child.type === Comment) return false;
		if (child.type === Fragment && !ensureValidVNode(child.children)) return false;
		return true;
	}) ? vnodes : null;
}
function toHandlers(obj, preserveCaseIfNecessary) {
	const ret = {};
	for (const key in obj) ret[preserveCaseIfNecessary && /[A-Z]/.test(key) ? `on:${key}` : toHandlerKey(key)] = obj[key];
	return ret;
}
var getPublicInstance = (i) => {
	if (!i) return null;
	if (isStatefulComponent(i)) return getComponentPublicInstance(i);
	return getPublicInstance(i.parent);
};
var publicPropertiesMap = /* @__PURE__ */ extend(/* @__PURE__ */ Object.create(null), {
	$: (i) => i,
	$el: (i) => i.vnode.el,
	$data: (i) => i.data,
	$props: (i) => i.props,
	$attrs: (i) => i.attrs,
	$slots: (i) => i.slots,
	$refs: (i) => i.refs,
	$parent: (i) => getPublicInstance(i.parent),
	$root: (i) => getPublicInstance(i.root),
	$emit: (i) => i.emit,
	$options: (i) => resolveMergedOptions(i),
	$forceUpdate: (i) => i.f || (i.f = () => {
		i.effect.dirty = true;
		queueJob(i.update);
	}),
	$nextTick: (i) => i.n || (i.n = nextTick.bind(i.proxy)),
	$watch: (i) => instanceWatch.bind(i)
});
var hasSetupBinding = (state, key) => state !== EMPTY_OBJ && !state.__isScriptSetup && hasOwn(state, key);
var PublicInstanceProxyHandlers = {
	get({ _: instance }, key) {
		if (key === "__v_skip") return true;
		const { ctx, setupState, data, props, accessCache, type, appContext } = instance;
		let normalizedProps;
		if (key[0] !== "$") {
			const n = accessCache[key];
			if (n !== void 0) switch (n) {
				case 1: return setupState[key];
				case 2: return data[key];
				case 4: return ctx[key];
				case 3: return props[key];
			}
			else if (hasSetupBinding(setupState, key)) {
				accessCache[key] = 1;
				return setupState[key];
			} else if (data !== EMPTY_OBJ && hasOwn(data, key)) {
				accessCache[key] = 2;
				return data[key];
			} else if ((normalizedProps = instance.propsOptions[0]) && hasOwn(normalizedProps, key)) {
				accessCache[key] = 3;
				return props[key];
			} else if (ctx !== EMPTY_OBJ && hasOwn(ctx, key)) {
				accessCache[key] = 4;
				return ctx[key];
			} else if (shouldCacheAccess) accessCache[key] = 0;
		}
		const publicGetter = publicPropertiesMap[key];
		let cssModule, globalProperties;
		if (publicGetter) {
			if (key === "$attrs") track(instance.attrs, "get", "");
			return publicGetter(instance);
		} else if ((cssModule = type.__cssModules) && (cssModule = cssModule[key])) return cssModule;
		else if (ctx !== EMPTY_OBJ && hasOwn(ctx, key)) {
			accessCache[key] = 4;
			return ctx[key];
		} else if (globalProperties = appContext.config.globalProperties, hasOwn(globalProperties, key)) return globalProperties[key];
	},
	set({ _: instance }, key, value) {
		const { data, setupState, ctx } = instance;
		if (hasSetupBinding(setupState, key)) {
			setupState[key] = value;
			return true;
		} else if (data !== EMPTY_OBJ && hasOwn(data, key)) {
			data[key] = value;
			return true;
		} else if (hasOwn(instance.props, key)) return false;
		if (key[0] === "$" && key.slice(1) in instance) return false;
		else ctx[key] = value;
		return true;
	},
	has({ _: { data, setupState, accessCache, ctx, appContext, propsOptions } }, key) {
		let normalizedProps;
		return !!accessCache[key] || data !== EMPTY_OBJ && hasOwn(data, key) || hasSetupBinding(setupState, key) || (normalizedProps = propsOptions[0]) && hasOwn(normalizedProps, key) || hasOwn(ctx, key) || hasOwn(publicPropertiesMap, key) || hasOwn(appContext.config.globalProperties, key);
	},
	defineProperty(target, key, descriptor) {
		if (descriptor.get != null) target._.accessCache[key] = 0;
		else if (hasOwn(descriptor, "value")) this.set(target, key, descriptor.value, null);
		return Reflect.defineProperty(target, key, descriptor);
	}
};
var RuntimeCompiledPublicInstanceProxyHandlers = /* @__PURE__ */ extend({}, PublicInstanceProxyHandlers, {
	get(target, key) {
		if (key === Symbol.unscopables) return;
		return PublicInstanceProxyHandlers.get(target, key, target);
	},
	has(_, key) {
		return key[0] !== "_" && !isGloballyAllowed(key);
	}
});
function defineProps() {
	return null;
}
function defineEmits() {
	return null;
}
function defineExpose(exposed) {}
function defineOptions(options) {}
function defineSlots() {
	return null;
}
function defineModel() {}
function withDefaults(props, defaults) {
	return null;
}
function useSlots() {
	return getContext().slots;
}
function useAttrs() {
	return getContext().attrs;
}
function getContext() {
	const i = getCurrentInstance();
	return i.setupContext || (i.setupContext = createSetupContext(i));
}
function normalizePropsOrEmits(props) {
	return isArray$1(props) ? props.reduce((normalized, p) => (normalized[p] = null, normalized), {}) : props;
}
function mergeDefaults(raw, defaults) {
	const props = normalizePropsOrEmits(raw);
	for (const key in defaults) {
		if (key.startsWith("__skip")) continue;
		let opt = props[key];
		if (opt) if (isArray$1(opt) || isFunction(opt)) opt = props[key] = {
			type: opt,
			default: defaults[key]
		};
		else opt.default = defaults[key];
		else if (opt === null) opt = props[key] = { default: defaults[key] };
		if (opt && defaults[`__skip_${key}`]) opt.skipFactory = true;
	}
	return props;
}
function mergeModels(a, b) {
	if (!a || !b) return a || b;
	if (isArray$1(a) && isArray$1(b)) return a.concat(b);
	return extend({}, normalizePropsOrEmits(a), normalizePropsOrEmits(b));
}
function createPropsRestProxy(props, excludedKeys) {
	const ret = {};
	for (const key in props) if (!excludedKeys.includes(key)) Object.defineProperty(ret, key, {
		enumerable: true,
		get: () => props[key]
	});
	return ret;
}
function withAsyncContext(getAwaitable) {
	const ctx = getCurrentInstance();
	let awaitable = getAwaitable();
	unsetCurrentInstance();
	if (isPromise(awaitable)) awaitable = awaitable.catch((e) => {
		setCurrentInstance(ctx);
		throw e;
	});
	return [awaitable, () => setCurrentInstance(ctx)];
}
var shouldCacheAccess = true;
function applyOptions(instance) {
	const options = resolveMergedOptions(instance);
	const publicThis = instance.proxy;
	const ctx = instance.ctx;
	shouldCacheAccess = false;
	if (options.beforeCreate) callHook$1(options.beforeCreate, instance, "bc");
	const { data: dataOptions, computed: computedOptions, methods, watch: watchOptions, provide: provideOptions, inject: injectOptions, created, beforeMount, mounted, beforeUpdate, updated, activated, deactivated, beforeDestroy, beforeUnmount, destroyed, unmounted, render, renderTracked, renderTriggered, errorCaptured, serverPrefetch, expose, inheritAttrs, components, directives, filters } = options;
	const checkDuplicateProperties = null;
	if (injectOptions) resolveInjections(injectOptions, ctx, checkDuplicateProperties);
	if (methods) for (const key in methods) {
		const methodHandler = methods[key];
		if (isFunction(methodHandler)) ctx[key] = methodHandler.bind(publicThis);
	}
	if (dataOptions) {
		const data = dataOptions.call(publicThis, publicThis);
		if (!isObject(data)) {} else instance.data = reactive(data);
	}
	shouldCacheAccess = true;
	if (computedOptions) for (const key in computedOptions) {
		const opt = computedOptions[key];
		const c = computed({
			get: isFunction(opt) ? opt.bind(publicThis, publicThis) : isFunction(opt.get) ? opt.get.bind(publicThis, publicThis) : NOOP,
			set: !isFunction(opt) && isFunction(opt.set) ? opt.set.bind(publicThis) : NOOP
		});
		Object.defineProperty(ctx, key, {
			enumerable: true,
			configurable: true,
			get: () => c.value,
			set: (v) => c.value = v
		});
	}
	if (watchOptions) for (const key in watchOptions) createWatcher(watchOptions[key], ctx, publicThis, key);
	if (provideOptions) {
		const provides = isFunction(provideOptions) ? provideOptions.call(publicThis) : provideOptions;
		Reflect.ownKeys(provides).forEach((key) => {
			provide(key, provides[key]);
		});
	}
	if (created) callHook$1(created, instance, "c");
	function registerLifecycleHook(register, hook) {
		if (isArray$1(hook)) hook.forEach((_hook) => register(_hook.bind(publicThis)));
		else if (hook) register(hook.bind(publicThis));
	}
	registerLifecycleHook(onBeforeMount, beforeMount);
	registerLifecycleHook(onMounted, mounted);
	registerLifecycleHook(onBeforeUpdate, beforeUpdate);
	registerLifecycleHook(onUpdated, updated);
	registerLifecycleHook(onActivated, activated);
	registerLifecycleHook(onDeactivated, deactivated);
	registerLifecycleHook(onErrorCaptured, errorCaptured);
	registerLifecycleHook(onRenderTracked, renderTracked);
	registerLifecycleHook(onRenderTriggered, renderTriggered);
	registerLifecycleHook(onBeforeUnmount, beforeUnmount);
	registerLifecycleHook(onUnmounted, unmounted);
	registerLifecycleHook(onServerPrefetch, serverPrefetch);
	if (isArray$1(expose)) {
		if (expose.length) {
			const exposed = instance.exposed || (instance.exposed = {});
			expose.forEach((key) => {
				Object.defineProperty(exposed, key, {
					get: () => publicThis[key],
					set: (val) => publicThis[key] = val
				});
			});
		} else if (!instance.exposed) instance.exposed = {};
	}
	if (render && instance.render === NOOP) instance.render = render;
	if (inheritAttrs != null) instance.inheritAttrs = inheritAttrs;
	if (components) instance.components = components;
	if (directives) instance.directives = directives;
}
function resolveInjections(injectOptions, ctx, checkDuplicateProperties = NOOP) {
	if (isArray$1(injectOptions)) injectOptions = normalizeInject(injectOptions);
	for (const key in injectOptions) {
		const opt = injectOptions[key];
		let injected;
		if (isObject(opt)) if ("default" in opt) injected = inject(opt.from || key, opt.default, true);
		else injected = inject(opt.from || key);
		else injected = inject(opt);
		if (isRef(injected)) Object.defineProperty(ctx, key, {
			enumerable: true,
			configurable: true,
			get: () => injected.value,
			set: (v) => injected.value = v
		});
		else ctx[key] = injected;
	}
}
function callHook$1(hook, instance, type) {
	callWithAsyncErrorHandling(isArray$1(hook) ? hook.map((h) => h.bind(instance.proxy)) : hook.bind(instance.proxy), instance, type);
}
function createWatcher(raw, ctx, publicThis, key) {
	const getter = key.includes(".") ? createPathGetter(publicThis, key) : () => publicThis[key];
	if (isString(raw)) {
		const handler = ctx[raw];
		if (isFunction(handler)) watch(getter, handler);
	} else if (isFunction(raw)) watch(getter, raw.bind(publicThis));
	else if (isObject(raw)) if (isArray$1(raw)) raw.forEach((r) => createWatcher(r, ctx, publicThis, key));
	else {
		const handler = isFunction(raw.handler) ? raw.handler.bind(publicThis) : ctx[raw.handler];
		if (isFunction(handler)) watch(getter, handler, raw);
	}
}
function resolveMergedOptions(instance) {
	const base = instance.type;
	const { mixins, extends: extendsOptions } = base;
	const { mixins: globalMixins, optionsCache: cache, config: { optionMergeStrategies } } = instance.appContext;
	const cached = cache.get(base);
	let resolved;
	if (cached) resolved = cached;
	else if (!globalMixins.length && !mixins && !extendsOptions) resolved = base;
	else {
		resolved = {};
		if (globalMixins.length) globalMixins.forEach((m) => mergeOptions$1(resolved, m, optionMergeStrategies, true));
		mergeOptions$1(resolved, base, optionMergeStrategies);
	}
	if (isObject(base)) cache.set(base, resolved);
	return resolved;
}
function mergeOptions$1(to, from, strats, asMixin = false) {
	const { mixins, extends: extendsOptions } = from;
	if (extendsOptions) mergeOptions$1(to, extendsOptions, strats, true);
	if (mixins) mixins.forEach((m) => mergeOptions$1(to, m, strats, true));
	for (const key in from) if (asMixin && key === "expose") {} else {
		const strat = internalOptionMergeStrats[key] || strats && strats[key];
		to[key] = strat ? strat(to[key], from[key]) : from[key];
	}
	return to;
}
var internalOptionMergeStrats = {
	data: mergeDataFn,
	props: mergeEmitsOrPropsOptions,
	emits: mergeEmitsOrPropsOptions,
	methods: mergeObjectOptions,
	computed: mergeObjectOptions,
	beforeCreate: mergeAsArray,
	created: mergeAsArray,
	beforeMount: mergeAsArray,
	mounted: mergeAsArray,
	beforeUpdate: mergeAsArray,
	updated: mergeAsArray,
	beforeDestroy: mergeAsArray,
	beforeUnmount: mergeAsArray,
	destroyed: mergeAsArray,
	unmounted: mergeAsArray,
	activated: mergeAsArray,
	deactivated: mergeAsArray,
	errorCaptured: mergeAsArray,
	serverPrefetch: mergeAsArray,
	components: mergeObjectOptions,
	directives: mergeObjectOptions,
	watch: mergeWatchOptions,
	provide: mergeDataFn,
	inject: mergeInject
};
function mergeDataFn(to, from) {
	if (!from) return to;
	if (!to) return from;
	return function mergedDataFn() {
		return extend(isFunction(to) ? to.call(this, this) : to, isFunction(from) ? from.call(this, this) : from);
	};
}
function mergeInject(to, from) {
	return mergeObjectOptions(normalizeInject(to), normalizeInject(from));
}
function normalizeInject(raw) {
	if (isArray$1(raw)) {
		const res = {};
		for (let i = 0; i < raw.length; i++) res[raw[i]] = raw[i];
		return res;
	}
	return raw;
}
function mergeAsArray(to, from) {
	return to ? [...new Set([].concat(to, from))] : from;
}
function mergeObjectOptions(to, from) {
	return to ? extend(/* @__PURE__ */ Object.create(null), to, from) : from;
}
function mergeEmitsOrPropsOptions(to, from) {
	if (to) {
		if (isArray$1(to) && isArray$1(from)) return [.../* @__PURE__ */ new Set([...to, ...from])];
		return extend(/* @__PURE__ */ Object.create(null), normalizePropsOrEmits(to), normalizePropsOrEmits(from != null ? from : {}));
	} else return from;
}
function mergeWatchOptions(to, from) {
	if (!to) return from;
	if (!from) return to;
	const merged = extend(/* @__PURE__ */ Object.create(null), to);
	for (const key in from) merged[key] = mergeAsArray(to[key], from[key]);
	return merged;
}
function createAppContext() {
	return {
		app: null,
		config: {
			isNativeTag: NO,
			performance: false,
			globalProperties: {},
			optionMergeStrategies: {},
			errorHandler: void 0,
			warnHandler: void 0,
			compilerOptions: {}
		},
		mixins: [],
		components: {},
		directives: {},
		provides: /* @__PURE__ */ Object.create(null),
		optionsCache: /* @__PURE__ */ new WeakMap(),
		propsCache: /* @__PURE__ */ new WeakMap(),
		emitsCache: /* @__PURE__ */ new WeakMap()
	};
}
var uid$1 = 0;
function createAppAPI(render, hydrate) {
	return function createApp(rootComponent, rootProps = null) {
		if (!isFunction(rootComponent)) rootComponent = extend({}, rootComponent);
		if (rootProps != null && !isObject(rootProps)) rootProps = null;
		const context = createAppContext();
		const installedPlugins = /* @__PURE__ */ new WeakSet();
		let isMounted = false;
		const app = context.app = {
			_uid: uid$1++,
			_component: rootComponent,
			_props: rootProps,
			_container: null,
			_context: context,
			_instance: null,
			version,
			get config() {
				return context.config;
			},
			set config(v) {},
			use(plugin, ...options) {
				if (installedPlugins.has(plugin)) {} else if (plugin && isFunction(plugin.install)) {
					installedPlugins.add(plugin);
					plugin.install(app, ...options);
				} else if (isFunction(plugin)) {
					installedPlugins.add(plugin);
					plugin(app, ...options);
				}
				return app;
			},
			mixin(mixin) {
				if (!context.mixins.includes(mixin)) context.mixins.push(mixin);
				return app;
			},
			component(name, component) {
				if (!component) return context.components[name];
				context.components[name] = component;
				return app;
			},
			directive(name, directive) {
				if (!directive) return context.directives[name];
				context.directives[name] = directive;
				return app;
			},
			mount(rootContainer, isHydrate, namespace) {
				if (!isMounted) {
					const vnode = createVNode(rootComponent, rootProps);
					vnode.appContext = context;
					if (namespace === true) namespace = "svg";
					else if (namespace === false) namespace = void 0;
					if (isHydrate && hydrate) hydrate(vnode, rootContainer);
					else render(vnode, rootContainer, namespace);
					isMounted = true;
					app._container = rootContainer;
					rootContainer.__vue_app__ = app;
					return getComponentPublicInstance(vnode.component);
				}
			},
			unmount() {
				if (isMounted) {
					render(null, app._container);
					delete app._container.__vue_app__;
				}
			},
			provide(key, value) {
				context.provides[key] = value;
				return app;
			},
			runWithContext(fn) {
				const lastApp = currentApp;
				currentApp = app;
				try {
					return fn();
				} finally {
					currentApp = lastApp;
				}
			}
		};
		return app;
	};
}
var currentApp = null;
function provide(key, value) {
	if (!currentInstance) {} else {
		let provides = currentInstance.provides;
		const parentProvides = currentInstance.parent && currentInstance.parent.provides;
		if (parentProvides === provides) provides = currentInstance.provides = Object.create(parentProvides);
		provides[key] = value;
	}
}
function inject(key, defaultValue, treatDefaultAsFactory = false) {
	const instance = currentInstance || currentRenderingInstance;
	if (instance || currentApp) {
		const provides = instance ? instance.parent == null ? instance.vnode.appContext && instance.vnode.appContext.provides : instance.parent.provides : currentApp._context.provides;
		if (provides && key in provides) return provides[key];
		else if (arguments.length > 1) return treatDefaultAsFactory && isFunction(defaultValue) ? defaultValue.call(instance && instance.proxy) : defaultValue;
	}
}
function hasInjectionContext() {
	return !!(currentInstance || currentRenderingInstance || currentApp);
}
var internalObjectProto = {};
var createInternalObject = () => Object.create(internalObjectProto);
var isInternalObject = (obj) => Object.getPrototypeOf(obj) === internalObjectProto;
function initProps(instance, rawProps, isStateful, isSSR = false) {
	const props = {};
	const attrs = createInternalObject();
	instance.propsDefaults = /* @__PURE__ */ Object.create(null);
	setFullProps(instance, rawProps, props, attrs);
	for (const key in instance.propsOptions[0]) if (!(key in props)) props[key] = void 0;
	if (isStateful) instance.props = isSSR ? props : shallowReactive(props);
	else if (!instance.type.props) instance.props = attrs;
	else instance.props = props;
	instance.attrs = attrs;
}
function updateProps(instance, rawProps, rawPrevProps, optimized) {
	const { props, attrs, vnode: { patchFlag } } = instance;
	const rawCurrentProps = toRaw(props);
	const [options] = instance.propsOptions;
	let hasAttrsChanged = false;
	if ((optimized || patchFlag > 0) && !(patchFlag & 16)) {
		if (patchFlag & 8) {
			const propsToUpdate = instance.vnode.dynamicProps;
			for (let i = 0; i < propsToUpdate.length; i++) {
				let key = propsToUpdate[i];
				if (isEmitListener(instance.emitsOptions, key)) continue;
				const value = rawProps[key];
				if (options) if (hasOwn(attrs, key)) {
					if (value !== attrs[key]) {
						attrs[key] = value;
						hasAttrsChanged = true;
					}
				} else {
					const camelizedKey = camelize(key);
					props[camelizedKey] = resolvePropValue(options, rawCurrentProps, camelizedKey, value, instance, false);
				}
				else if (value !== attrs[key]) {
					attrs[key] = value;
					hasAttrsChanged = true;
				}
			}
		}
	} else {
		if (setFullProps(instance, rawProps, props, attrs)) hasAttrsChanged = true;
		let kebabKey;
		for (const key in rawCurrentProps) if (!rawProps || !hasOwn(rawProps, key) && ((kebabKey = hyphenate(key)) === key || !hasOwn(rawProps, kebabKey))) if (options) {
			if (rawPrevProps && (rawPrevProps[key] !== void 0 || rawPrevProps[kebabKey] !== void 0)) props[key] = resolvePropValue(options, rawCurrentProps, key, void 0, instance, true);
		} else delete props[key];
		if (attrs !== rawCurrentProps) {
			for (const key in attrs) if (!rawProps || !hasOwn(rawProps, key) && true) {
				delete attrs[key];
				hasAttrsChanged = true;
			}
		}
	}
	if (hasAttrsChanged) trigger(instance.attrs, "set", "");
}
function setFullProps(instance, rawProps, props, attrs) {
	const [options, needCastKeys] = instance.propsOptions;
	let hasAttrsChanged = false;
	let rawCastValues;
	if (rawProps) for (let key in rawProps) {
		if (isReservedProp(key)) continue;
		const value = rawProps[key];
		let camelKey;
		if (options && hasOwn(options, camelKey = camelize(key))) if (!needCastKeys || !needCastKeys.includes(camelKey)) props[camelKey] = value;
		else (rawCastValues || (rawCastValues = {}))[camelKey] = value;
		else if (!isEmitListener(instance.emitsOptions, key)) {
			if (!(key in attrs) || value !== attrs[key]) {
				attrs[key] = value;
				hasAttrsChanged = true;
			}
		}
	}
	if (needCastKeys) {
		const rawCurrentProps = toRaw(props);
		const castValues = rawCastValues || EMPTY_OBJ;
		for (let i = 0; i < needCastKeys.length; i++) {
			const key = needCastKeys[i];
			props[key] = resolvePropValue(options, rawCurrentProps, key, castValues[key], instance, !hasOwn(castValues, key));
		}
	}
	return hasAttrsChanged;
}
function resolvePropValue(options, props, key, value, instance, isAbsent) {
	const opt = options[key];
	if (opt != null) {
		const hasDefault = hasOwn(opt, "default");
		if (hasDefault && value === void 0) {
			const defaultValue = opt.default;
			if (opt.type !== Function && !opt.skipFactory && isFunction(defaultValue)) {
				const { propsDefaults } = instance;
				if (key in propsDefaults) value = propsDefaults[key];
				else {
					const reset = setCurrentInstance(instance);
					value = propsDefaults[key] = defaultValue.call(null, props);
					reset();
				}
			} else value = defaultValue;
		}
		if (opt[0]) {
			if (isAbsent && !hasDefault) value = false;
			else if (opt[1] && (value === "" || value === hyphenate(key))) value = true;
		}
	}
	return value;
}
function normalizePropsOptions(comp, appContext, asMixin = false) {
	const cache = appContext.propsCache;
	const cached = cache.get(comp);
	if (cached) return cached;
	const raw = comp.props;
	const normalized = {};
	const needCastKeys = [];
	let hasExtends = false;
	if (!isFunction(comp)) {
		const extendProps = (raw2) => {
			hasExtends = true;
			const [props, keys] = normalizePropsOptions(raw2, appContext, true);
			extend(normalized, props);
			if (keys) needCastKeys.push(...keys);
		};
		if (!asMixin && appContext.mixins.length) appContext.mixins.forEach(extendProps);
		if (comp.extends) extendProps(comp.extends);
		if (comp.mixins) comp.mixins.forEach(extendProps);
	}
	if (!raw && !hasExtends) {
		if (isObject(comp)) cache.set(comp, EMPTY_ARR);
		return EMPTY_ARR;
	}
	if (isArray$1(raw)) for (let i = 0; i < raw.length; i++) {
		const normalizedKey = camelize(raw[i]);
		if (validatePropName(normalizedKey)) normalized[normalizedKey] = EMPTY_OBJ;
	}
	else if (raw) for (const key in raw) {
		const normalizedKey = camelize(key);
		if (validatePropName(normalizedKey)) {
			const opt = raw[key];
			const prop = normalized[normalizedKey] = isArray$1(opt) || isFunction(opt) ? { type: opt } : extend({}, opt);
			if (prop) {
				const booleanIndex = getTypeIndex(Boolean, prop.type);
				const stringIndex = getTypeIndex(String, prop.type);
				prop[0] = booleanIndex > -1;
				prop[1] = stringIndex < 0 || booleanIndex < stringIndex;
				if (booleanIndex > -1 || hasOwn(prop, "default")) needCastKeys.push(normalizedKey);
			}
		}
	}
	const res = [normalized, needCastKeys];
	if (isObject(comp)) cache.set(comp, res);
	return res;
}
function validatePropName(key) {
	if (key[0] !== "$" && !isReservedProp(key)) return true;
	return false;
}
function getType(ctor) {
	if (ctor === null) return "null";
	if (typeof ctor === "function") return ctor.name || "";
	else if (typeof ctor === "object") return ctor.constructor && ctor.constructor.name || "";
	return "";
}
function isSameType(a, b) {
	return getType(a) === getType(b);
}
function getTypeIndex(type, expectedTypes) {
	if (isArray$1(expectedTypes)) return expectedTypes.findIndex((t) => isSameType(t, type));
	else if (isFunction(expectedTypes)) return isSameType(expectedTypes, type) ? 0 : -1;
	return -1;
}
var isInternalKey = (key) => key[0] === "_" || key === "$stable";
var normalizeSlotValue = (value) => isArray$1(value) ? value.map(normalizeVNode) : [normalizeVNode(value)];
var normalizeSlot$1 = (key, rawSlot, ctx) => {
	if (rawSlot._n) return rawSlot;
	const normalized = withCtx((...args) => {
		return normalizeSlotValue(rawSlot(...args));
	}, ctx);
	normalized._c = false;
	return normalized;
};
var normalizeObjectSlots = (rawSlots, slots, instance) => {
	const ctx = rawSlots._ctx;
	for (const key in rawSlots) {
		if (isInternalKey(key)) continue;
		const value = rawSlots[key];
		if (isFunction(value)) slots[key] = normalizeSlot$1(key, value, ctx);
		else if (value != null) {
			const normalized = normalizeSlotValue(value);
			slots[key] = () => normalized;
		}
	}
};
var normalizeVNodeSlots = (instance, children) => {
	const normalized = normalizeSlotValue(children);
	instance.slots.default = () => normalized;
};
var initSlots = (instance, children) => {
	const slots = instance.slots = createInternalObject();
	if (instance.vnode.shapeFlag & 32) {
		const type = children._;
		if (type) {
			extend(slots, children);
			def(slots, "_", type, true);
		} else normalizeObjectSlots(children, slots);
	} else if (children) normalizeVNodeSlots(instance, children);
};
var updateSlots = (instance, children, optimized) => {
	const { vnode, slots } = instance;
	let needDeletionCheck = true;
	let deletionComparisonTarget = EMPTY_OBJ;
	if (vnode.shapeFlag & 32) {
		const type = children._;
		if (type) if (optimized && type === 1) needDeletionCheck = false;
		else {
			extend(slots, children);
			if (!optimized && type === 1) delete slots._;
		}
		else {
			needDeletionCheck = !children.$stable;
			normalizeObjectSlots(children, slots);
		}
		deletionComparisonTarget = children;
	} else if (children) {
		normalizeVNodeSlots(instance, children);
		deletionComparisonTarget = { default: 1 };
	}
	if (needDeletionCheck) {
		for (const key in slots) if (!isInternalKey(key) && deletionComparisonTarget[key] == null) delete slots[key];
	}
};
function setRef(rawRef, oldRawRef, parentSuspense, vnode, isUnmount = false) {
	if (isArray$1(rawRef)) {
		rawRef.forEach((r, i) => setRef(r, oldRawRef && (isArray$1(oldRawRef) ? oldRawRef[i] : oldRawRef), parentSuspense, vnode, isUnmount));
		return;
	}
	if (isAsyncWrapper(vnode) && !isUnmount) return;
	const refValue = vnode.shapeFlag & 4 ? getComponentPublicInstance(vnode.component) : vnode.el;
	const value = isUnmount ? null : refValue;
	const { i: owner, r: ref } = rawRef;
	const oldRef = oldRawRef && oldRawRef.r;
	const refs = owner.refs === EMPTY_OBJ ? owner.refs = {} : owner.refs;
	const setupState = owner.setupState;
	if (oldRef != null && oldRef !== ref) {
		if (isString(oldRef)) {
			refs[oldRef] = null;
			if (hasOwn(setupState, oldRef)) setupState[oldRef] = null;
		} else if (isRef(oldRef)) oldRef.value = null;
	}
	if (isFunction(ref)) callWithErrorHandling(ref, owner, 12, [value, refs]);
	else {
		const _isString = isString(ref);
		const _isRef = isRef(ref);
		if (_isString || _isRef) {
			const doSet = () => {
				if (rawRef.f) {
					const existing = _isString ? hasOwn(setupState, ref) ? setupState[ref] : refs[ref] : ref.value;
					if (isUnmount) isArray$1(existing) && remove(existing, refValue);
					else if (!isArray$1(existing)) if (_isString) {
						refs[ref] = [refValue];
						if (hasOwn(setupState, ref)) setupState[ref] = refs[ref];
					} else {
						ref.value = [refValue];
						if (rawRef.k) refs[rawRef.k] = ref.value;
					}
					else if (!existing.includes(refValue)) existing.push(refValue);
				} else if (_isString) {
					refs[ref] = value;
					if (hasOwn(setupState, ref)) setupState[ref] = value;
				} else if (_isRef) {
					ref.value = value;
					if (rawRef.k) refs[rawRef.k] = value;
				}
			};
			if (value) {
				doSet.id = -1;
				queuePostRenderEffect(doSet, parentSuspense);
			} else doSet();
		}
	}
}
var hasLoggedMismatchError = false;
var logMismatchError = () => {
	if (hasLoggedMismatchError) return;
	console.error("Hydration completed but contains mismatches.");
	hasLoggedMismatchError = true;
};
var isSVGContainer = (container) => container.namespaceURI.includes("svg") && container.tagName !== "foreignObject";
var isMathMLContainer = (container) => container.namespaceURI.includes("MathML");
var getContainerType = (container) => {
	if (isSVGContainer(container)) return "svg";
	if (isMathMLContainer(container)) return "mathml";
};
var isComment = (node) => node.nodeType === 8;
function createHydrationFunctions(rendererInternals) {
	const { mt: mountComponent, p: patch, o: { patchProp, createText, nextSibling, parentNode, remove, insert, createComment } } = rendererInternals;
	const hydrate = (vnode, container) => {
		if (!container.hasChildNodes()) {
			patch(null, vnode, container);
			flushPostFlushCbs();
			container._vnode = vnode;
			return;
		}
		hydrateNode(container.firstChild, vnode, null, null, null);
		flushPostFlushCbs();
		container._vnode = vnode;
	};
	const hydrateNode = (node, vnode, parentComponent, parentSuspense, slotScopeIds, optimized = false) => {
		optimized = optimized || !!vnode.dynamicChildren;
		const isFragmentStart = isComment(node) && node.data === "[";
		const onMismatch = () => handleMismatch(node, vnode, parentComponent, parentSuspense, slotScopeIds, isFragmentStart);
		const { type, ref, shapeFlag, patchFlag } = vnode;
		let domType = node.nodeType;
		vnode.el = node;
		if (patchFlag === -2) {
			optimized = false;
			vnode.dynamicChildren = null;
		}
		let nextNode = null;
		switch (type) {
			case Text:
				if (domType !== 3) if (vnode.children === "") {
					insert(vnode.el = createText(""), parentNode(node), node);
					nextNode = node;
				} else nextNode = onMismatch();
				else {
					if (node.data !== vnode.children) {
						logMismatchError();
						node.data = vnode.children;
					}
					nextNode = nextSibling(node);
				}
				break;
			case Comment:
				if (isTemplateNode(node)) {
					nextNode = nextSibling(node);
					replaceNode(vnode.el = node.content.firstChild, node, parentComponent);
				} else if (domType !== 8 || isFragmentStart) nextNode = onMismatch();
				else nextNode = nextSibling(node);
				break;
			case Static:
				if (isFragmentStart) {
					node = nextSibling(node);
					domType = node.nodeType;
				}
				if (domType === 1 || domType === 3) {
					nextNode = node;
					const needToAdoptContent = !vnode.children.length;
					for (let i = 0; i < vnode.staticCount; i++) {
						if (needToAdoptContent) vnode.children += nextNode.nodeType === 1 ? nextNode.outerHTML : nextNode.data;
						if (i === vnode.staticCount - 1) vnode.anchor = nextNode;
						nextNode = nextSibling(nextNode);
					}
					return isFragmentStart ? nextSibling(nextNode) : nextNode;
				} else onMismatch();
				break;
			case Fragment:
				if (!isFragmentStart) nextNode = onMismatch();
				else nextNode = hydrateFragment(node, vnode, parentComponent, parentSuspense, slotScopeIds, optimized);
				break;
			default: if (shapeFlag & 1) if ((domType !== 1 || vnode.type.toLowerCase() !== node.tagName.toLowerCase()) && !isTemplateNode(node)) nextNode = onMismatch();
			else nextNode = hydrateElement(node, vnode, parentComponent, parentSuspense, slotScopeIds, optimized);
			else if (shapeFlag & 6) {
				vnode.slotScopeIds = slotScopeIds;
				const container = parentNode(node);
				if (isFragmentStart) nextNode = locateClosingAnchor(node);
				else if (isComment(node) && node.data === "teleport start") nextNode = locateClosingAnchor(node, node.data, "teleport end");
				else nextNode = nextSibling(node);
				mountComponent(vnode, container, null, parentComponent, parentSuspense, getContainerType(container), optimized);
				if (isAsyncWrapper(vnode)) {
					let subTree;
					if (isFragmentStart) {
						subTree = createVNode(Fragment);
						subTree.anchor = nextNode ? nextNode.previousSibling : container.lastChild;
					} else subTree = node.nodeType === 3 ? createTextVNode("") : createVNode("div");
					subTree.el = node;
					vnode.component.subTree = subTree;
				}
			} else if (shapeFlag & 64) if (domType !== 8) nextNode = onMismatch();
			else nextNode = vnode.type.hydrate(node, vnode, parentComponent, parentSuspense, slotScopeIds, optimized, rendererInternals, hydrateChildren);
			else if (shapeFlag & 128) nextNode = vnode.type.hydrate(node, vnode, parentComponent, parentSuspense, getContainerType(parentNode(node)), slotScopeIds, optimized, rendererInternals, hydrateNode);
		}
		if (ref != null) setRef(ref, null, parentSuspense, vnode);
		return nextNode;
	};
	const hydrateElement = (el, vnode, parentComponent, parentSuspense, slotScopeIds, optimized) => {
		optimized = optimized || !!vnode.dynamicChildren;
		const { type, props, patchFlag, shapeFlag, dirs, transition } = vnode;
		const forcePatch = type === "input" || type === "option";
		if (forcePatch || patchFlag !== -1) {
			if (dirs) invokeDirectiveHook(vnode, null, parentComponent, "created");
			let needCallTransitionHooks = false;
			if (isTemplateNode(el)) {
				needCallTransitionHooks = needTransition(parentSuspense, transition) && parentComponent && parentComponent.vnode.props && parentComponent.vnode.props.appear;
				const content = el.content.firstChild;
				if (needCallTransitionHooks) transition.beforeEnter(content);
				replaceNode(content, el, parentComponent);
				vnode.el = el = content;
			}
			if (shapeFlag & 16 && !(props && (props.innerHTML || props.textContent))) {
				let next = hydrateChildren(el.firstChild, vnode, el, parentComponent, parentSuspense, slotScopeIds, optimized);
				while (next) {
					logMismatchError();
					const cur = next;
					next = next.nextSibling;
					remove(cur);
				}
			} else if (shapeFlag & 8) {
				if (el.textContent !== vnode.children) {
					logMismatchError();
					el.textContent = vnode.children;
				}
			}
			if (props) {
				if (forcePatch || !optimized || patchFlag & 48) {
					for (const key in props) if (forcePatch && (key.endsWith("value") || key === "indeterminate") || isOn(key) && !isReservedProp(key) || key[0] === ".") patchProp(el, key, null, props[key], void 0, void 0, parentComponent);
				} else if (props.onClick) patchProp(el, "onClick", null, props.onClick, void 0, void 0, parentComponent);
			}
			let vnodeHooks;
			if (vnodeHooks = props && props.onVnodeBeforeMount) invokeVNodeHook(vnodeHooks, parentComponent, vnode);
			if (dirs) invokeDirectiveHook(vnode, null, parentComponent, "beforeMount");
			if ((vnodeHooks = props && props.onVnodeMounted) || dirs || needCallTransitionHooks) queueEffectWithSuspense(() => {
				vnodeHooks && invokeVNodeHook(vnodeHooks, parentComponent, vnode);
				needCallTransitionHooks && transition.enter(el);
				dirs && invokeDirectiveHook(vnode, null, parentComponent, "mounted");
			}, parentSuspense);
		}
		return el.nextSibling;
	};
	const hydrateChildren = (node, parentVNode, container, parentComponent, parentSuspense, slotScopeIds, optimized) => {
		optimized = optimized || !!parentVNode.dynamicChildren;
		const children = parentVNode.children;
		const l = children.length;
		for (let i = 0; i < l; i++) {
			const vnode = optimized ? children[i] : children[i] = normalizeVNode(children[i]);
			if (node) node = hydrateNode(node, vnode, parentComponent, parentSuspense, slotScopeIds, optimized);
			else if (vnode.type === Text && !vnode.children) insert(vnode.el = createText(""), container);
			else {
				logMismatchError();
				patch(null, vnode, container, null, parentComponent, parentSuspense, getContainerType(container), slotScopeIds);
			}
		}
		return node;
	};
	const hydrateFragment = (node, vnode, parentComponent, parentSuspense, slotScopeIds, optimized) => {
		const { slotScopeIds: fragmentSlotScopeIds } = vnode;
		if (fragmentSlotScopeIds) slotScopeIds = slotScopeIds ? slotScopeIds.concat(fragmentSlotScopeIds) : fragmentSlotScopeIds;
		const container = parentNode(node);
		const next = hydrateChildren(nextSibling(node), vnode, container, parentComponent, parentSuspense, slotScopeIds, optimized);
		if (next && isComment(next) && next.data === "]") return nextSibling(vnode.anchor = next);
		else {
			logMismatchError();
			insert(vnode.anchor = createComment(`]`), container, next);
			return next;
		}
	};
	const handleMismatch = (node, vnode, parentComponent, parentSuspense, slotScopeIds, isFragment) => {
		logMismatchError();
		vnode.el = null;
		if (isFragment) {
			const end = locateClosingAnchor(node);
			while (true) {
				const next2 = nextSibling(node);
				if (next2 && next2 !== end) remove(next2);
				else break;
			}
		}
		const next = nextSibling(node);
		const container = parentNode(node);
		remove(node);
		patch(null, vnode, container, next, parentComponent, parentSuspense, getContainerType(container), slotScopeIds);
		return next;
	};
	const locateClosingAnchor = (node, open = "[", close = "]") => {
		let match = 0;
		while (node) {
			node = nextSibling(node);
			if (node && isComment(node)) {
				if (node.data === open) match++;
				if (node.data === close) if (match === 0) return nextSibling(node);
				else match--;
			}
		}
		return node;
	};
	const replaceNode = (newNode, oldNode, parentComponent) => {
		const parentNode2 = oldNode.parentNode;
		if (parentNode2) parentNode2.replaceChild(newNode, oldNode);
		let parent = parentComponent;
		while (parent) {
			if (parent.vnode.el === oldNode) parent.vnode.el = parent.subTree.el = newNode;
			parent = parent.parent;
		}
	};
	const isTemplateNode = (node) => {
		return node.nodeType === 1 && node.tagName.toLowerCase() === "template";
	};
	return [hydrate, hydrateNode];
}
function initFeatureFlags() {}
var queuePostRenderEffect = queueEffectWithSuspense;
function createRenderer(options) {
	return baseCreateRenderer(options);
}
function createHydrationRenderer(options) {
	return baseCreateRenderer(options, createHydrationFunctions);
}
function baseCreateRenderer(options, createHydrationFns) {
	initFeatureFlags();
	const target = getGlobalThis();
	target.__VUE__ = true;
	const { insert: hostInsert, remove: hostRemove, patchProp: hostPatchProp, createElement: hostCreateElement, createText: hostCreateText, createComment: hostCreateComment, setText: hostSetText, setElementText: hostSetElementText, parentNode: hostParentNode, nextSibling: hostNextSibling, setScopeId: hostSetScopeId = NOOP, insertStaticContent: hostInsertStaticContent } = options;
	const patch = (n1, n2, container, anchor = null, parentComponent = null, parentSuspense = null, namespace = void 0, slotScopeIds = null, optimized = !!n2.dynamicChildren) => {
		if (n1 === n2) return;
		if (n1 && !isSameVNodeType(n1, n2)) {
			anchor = getNextHostNode(n1);
			unmount(n1, parentComponent, parentSuspense, true);
			n1 = null;
		}
		if (n2.patchFlag === -2) {
			optimized = false;
			n2.dynamicChildren = null;
		}
		const { type, ref, shapeFlag } = n2;
		switch (type) {
			case Text:
				processText(n1, n2, container, anchor);
				break;
			case Comment:
				processCommentNode(n1, n2, container, anchor);
				break;
			case Static:
				if (n1 == null) mountStaticNode(n2, container, anchor, namespace);
				break;
			case Fragment:
				processFragment(n1, n2, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized);
				break;
			default: if (shapeFlag & 1) processElement(n1, n2, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized);
			else if (shapeFlag & 6) processComponent(n1, n2, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized);
			else if (shapeFlag & 64) type.process(n1, n2, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized, internals);
			else if (shapeFlag & 128) type.process(n1, n2, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized, internals);
		}
		if (ref != null && parentComponent) setRef(ref, n1 && n1.ref, parentSuspense, n2 || n1, !n2);
	};
	const processText = (n1, n2, container, anchor) => {
		if (n1 == null) hostInsert(n2.el = hostCreateText(n2.children), container, anchor);
		else {
			const el = n2.el = n1.el;
			if (n2.children !== n1.children) hostSetText(el, n2.children);
		}
	};
	const processCommentNode = (n1, n2, container, anchor) => {
		if (n1 == null) hostInsert(n2.el = hostCreateComment(n2.children || ""), container, anchor);
		else n2.el = n1.el;
	};
	const mountStaticNode = (n2, container, anchor, namespace) => {
		[n2.el, n2.anchor] = hostInsertStaticContent(n2.children, container, anchor, namespace, n2.el, n2.anchor);
	};
	const moveStaticNode = ({ el, anchor }, container, nextSibling) => {
		let next;
		while (el && el !== anchor) {
			next = hostNextSibling(el);
			hostInsert(el, container, nextSibling);
			el = next;
		}
		hostInsert(anchor, container, nextSibling);
	};
	const removeStaticNode = ({ el, anchor }) => {
		let next;
		while (el && el !== anchor) {
			next = hostNextSibling(el);
			hostRemove(el);
			el = next;
		}
		hostRemove(anchor);
	};
	const processElement = (n1, n2, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized) => {
		if (n2.type === "svg") namespace = "svg";
		else if (n2.type === "math") namespace = "mathml";
		if (n1 == null) mountElement(n2, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized);
		else patchElement(n1, n2, parentComponent, parentSuspense, namespace, slotScopeIds, optimized);
	};
	const mountElement = (vnode, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized) => {
		let el;
		let vnodeHook;
		const { props, shapeFlag, transition, dirs } = vnode;
		el = vnode.el = hostCreateElement(vnode.type, namespace, props && props.is, props);
		if (shapeFlag & 8) hostSetElementText(el, vnode.children);
		else if (shapeFlag & 16) mountChildren(vnode.children, el, null, parentComponent, parentSuspense, resolveChildrenNamespace(vnode, namespace), slotScopeIds, optimized);
		if (dirs) invokeDirectiveHook(vnode, null, parentComponent, "created");
		setScopeId(el, vnode, vnode.scopeId, slotScopeIds, parentComponent);
		if (props) {
			for (const key in props) if (key !== "value" && !isReservedProp(key)) hostPatchProp(el, key, null, props[key], namespace, vnode.children, parentComponent, parentSuspense, unmountChildren);
			if ("value" in props) hostPatchProp(el, "value", null, props.value, namespace);
			if (vnodeHook = props.onVnodeBeforeMount) invokeVNodeHook(vnodeHook, parentComponent, vnode);
		}
		if (dirs) invokeDirectiveHook(vnode, null, parentComponent, "beforeMount");
		const needCallTransitionHooks = needTransition(parentSuspense, transition);
		if (needCallTransitionHooks) transition.beforeEnter(el);
		hostInsert(el, container, anchor);
		if ((vnodeHook = props && props.onVnodeMounted) || needCallTransitionHooks || dirs) queuePostRenderEffect(() => {
			vnodeHook && invokeVNodeHook(vnodeHook, parentComponent, vnode);
			needCallTransitionHooks && transition.enter(el);
			dirs && invokeDirectiveHook(vnode, null, parentComponent, "mounted");
		}, parentSuspense);
	};
	const setScopeId = (el, vnode, scopeId, slotScopeIds, parentComponent) => {
		if (scopeId) hostSetScopeId(el, scopeId);
		if (slotScopeIds) for (let i = 0; i < slotScopeIds.length; i++) hostSetScopeId(el, slotScopeIds[i]);
		if (parentComponent) {
			if (vnode === parentComponent.subTree) {
				const parentVNode = parentComponent.vnode;
				setScopeId(el, parentVNode, parentVNode.scopeId, parentVNode.slotScopeIds, parentComponent.parent);
			}
		}
	};
	const mountChildren = (children, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized, start = 0) => {
		for (let i = start; i < children.length; i++) patch(null, children[i] = optimized ? cloneIfMounted(children[i]) : normalizeVNode(children[i]), container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized);
	};
	const patchElement = (n1, n2, parentComponent, parentSuspense, namespace, slotScopeIds, optimized) => {
		const el = n2.el = n1.el;
		let { patchFlag, dynamicChildren, dirs } = n2;
		patchFlag |= n1.patchFlag & 16;
		const oldProps = n1.props || EMPTY_OBJ;
		const newProps = n2.props || EMPTY_OBJ;
		let vnodeHook;
		parentComponent && toggleRecurse(parentComponent, false);
		if (vnodeHook = newProps.onVnodeBeforeUpdate) invokeVNodeHook(vnodeHook, parentComponent, n2, n1);
		if (dirs) invokeDirectiveHook(n2, n1, parentComponent, "beforeUpdate");
		parentComponent && toggleRecurse(parentComponent, true);
		if (dynamicChildren) patchBlockChildren(n1.dynamicChildren, dynamicChildren, el, parentComponent, parentSuspense, resolveChildrenNamespace(n2, namespace), slotScopeIds);
		else if (!optimized) patchChildren(n1, n2, el, null, parentComponent, parentSuspense, resolveChildrenNamespace(n2, namespace), slotScopeIds, false);
		if (patchFlag > 0) {
			if (patchFlag & 16) patchProps(el, n2, oldProps, newProps, parentComponent, parentSuspense, namespace);
			else {
				if (patchFlag & 2) {
					if (oldProps.class !== newProps.class) hostPatchProp(el, "class", null, newProps.class, namespace);
				}
				if (patchFlag & 4) hostPatchProp(el, "style", oldProps.style, newProps.style, namespace);
				if (patchFlag & 8) {
					const propsToUpdate = n2.dynamicProps;
					for (let i = 0; i < propsToUpdate.length; i++) {
						const key = propsToUpdate[i];
						const prev = oldProps[key];
						const next = newProps[key];
						if (next !== prev || key === "value") hostPatchProp(el, key, prev, next, namespace, n1.children, parentComponent, parentSuspense, unmountChildren);
					}
				}
			}
			if (patchFlag & 1) {
				if (n1.children !== n2.children) hostSetElementText(el, n2.children);
			}
		} else if (!optimized && dynamicChildren == null) patchProps(el, n2, oldProps, newProps, parentComponent, parentSuspense, namespace);
		if ((vnodeHook = newProps.onVnodeUpdated) || dirs) queuePostRenderEffect(() => {
			vnodeHook && invokeVNodeHook(vnodeHook, parentComponent, n2, n1);
			dirs && invokeDirectiveHook(n2, n1, parentComponent, "updated");
		}, parentSuspense);
	};
	const patchBlockChildren = (oldChildren, newChildren, fallbackContainer, parentComponent, parentSuspense, namespace, slotScopeIds) => {
		for (let i = 0; i < newChildren.length; i++) {
			const oldVNode = oldChildren[i];
			const newVNode = newChildren[i];
			patch(oldVNode, newVNode, oldVNode.el && (oldVNode.type === Fragment || !isSameVNodeType(oldVNode, newVNode) || oldVNode.shapeFlag & 70) ? hostParentNode(oldVNode.el) : fallbackContainer, null, parentComponent, parentSuspense, namespace, slotScopeIds, true);
		}
	};
	const patchProps = (el, vnode, oldProps, newProps, parentComponent, parentSuspense, namespace) => {
		if (oldProps !== newProps) {
			if (oldProps !== EMPTY_OBJ) {
				for (const key in oldProps) if (!isReservedProp(key) && !(key in newProps)) hostPatchProp(el, key, oldProps[key], null, namespace, vnode.children, parentComponent, parentSuspense, unmountChildren);
			}
			for (const key in newProps) {
				if (isReservedProp(key)) continue;
				const next = newProps[key];
				const prev = oldProps[key];
				if (next !== prev && key !== "value") hostPatchProp(el, key, prev, next, namespace, vnode.children, parentComponent, parentSuspense, unmountChildren);
			}
			if ("value" in newProps) hostPatchProp(el, "value", oldProps.value, newProps.value, namespace);
		}
	};
	const processFragment = (n1, n2, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized) => {
		const fragmentStartAnchor = n2.el = n1 ? n1.el : hostCreateText("");
		const fragmentEndAnchor = n2.anchor = n1 ? n1.anchor : hostCreateText("");
		let { patchFlag, dynamicChildren, slotScopeIds: fragmentSlotScopeIds } = n2;
		if (fragmentSlotScopeIds) slotScopeIds = slotScopeIds ? slotScopeIds.concat(fragmentSlotScopeIds) : fragmentSlotScopeIds;
		if (n1 == null) {
			hostInsert(fragmentStartAnchor, container, anchor);
			hostInsert(fragmentEndAnchor, container, anchor);
			mountChildren(n2.children || [], container, fragmentEndAnchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized);
		} else if (patchFlag > 0 && patchFlag & 64 && dynamicChildren && n1.dynamicChildren) {
			patchBlockChildren(n1.dynamicChildren, dynamicChildren, container, parentComponent, parentSuspense, namespace, slotScopeIds);
			if (n2.key != null || parentComponent && n2 === parentComponent.subTree) traverseStaticChildren(n1, n2, true);
		} else patchChildren(n1, n2, container, fragmentEndAnchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized);
	};
	const processComponent = (n1, n2, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized) => {
		n2.slotScopeIds = slotScopeIds;
		if (n1 == null) if (n2.shapeFlag & 512) parentComponent.ctx.activate(n2, container, anchor, namespace, optimized);
		else mountComponent(n2, container, anchor, parentComponent, parentSuspense, namespace, optimized);
		else updateComponent(n1, n2, optimized);
	};
	const mountComponent = (initialVNode, container, anchor, parentComponent, parentSuspense, namespace, optimized) => {
		const instance = initialVNode.component = createComponentInstance(initialVNode, parentComponent, parentSuspense);
		if (isKeepAlive(initialVNode)) instance.ctx.renderer = internals;
		setupComponent(instance);
		if (instance.asyncDep) {
			parentSuspense && parentSuspense.registerDep(instance, setupRenderEffect, optimized);
			if (!initialVNode.el) processCommentNode(null, instance.subTree = createVNode(Comment), container, anchor);
		} else setupRenderEffect(instance, initialVNode, container, anchor, parentSuspense, namespace, optimized);
	};
	const updateComponent = (n1, n2, optimized) => {
		const instance = n2.component = n1.component;
		if (shouldUpdateComponent(n1, n2, optimized)) if (instance.asyncDep && !instance.asyncResolved) {
			updateComponentPreRender(instance, n2, optimized);
			return;
		} else {
			instance.next = n2;
			invalidateJob(instance.update);
			instance.effect.dirty = true;
			instance.update();
		}
		else {
			n2.el = n1.el;
			instance.vnode = n2;
		}
	};
	const setupRenderEffect = (instance, initialVNode, container, anchor, parentSuspense, namespace, optimized) => {
		const componentUpdateFn = () => {
			if (!instance.isMounted) {
				let vnodeHook;
				const { el, props } = initialVNode;
				const { bm, m, parent } = instance;
				const isAsyncWrapperVNode = isAsyncWrapper(initialVNode);
				toggleRecurse(instance, false);
				if (bm) invokeArrayFns(bm);
				if (!isAsyncWrapperVNode && (vnodeHook = props && props.onVnodeBeforeMount)) invokeVNodeHook(vnodeHook, parent, initialVNode);
				toggleRecurse(instance, true);
				if (el && hydrateNode) {
					const hydrateSubTree = () => {
						instance.subTree = renderComponentRoot(instance);
						hydrateNode(el, instance.subTree, instance, parentSuspense, null);
					};
					if (isAsyncWrapperVNode) initialVNode.type.__asyncLoader().then(() => !instance.isUnmounted && hydrateSubTree());
					else hydrateSubTree();
				} else {
					const subTree = instance.subTree = renderComponentRoot(instance);
					patch(null, subTree, container, anchor, instance, parentSuspense, namespace);
					initialVNode.el = subTree.el;
				}
				if (m) queuePostRenderEffect(m, parentSuspense);
				if (!isAsyncWrapperVNode && (vnodeHook = props && props.onVnodeMounted)) {
					const scopedInitialVNode = initialVNode;
					queuePostRenderEffect(() => invokeVNodeHook(vnodeHook, parent, scopedInitialVNode), parentSuspense);
				}
				if (initialVNode.shapeFlag & 256 || parent && isAsyncWrapper(parent.vnode) && parent.vnode.shapeFlag & 256) instance.a && queuePostRenderEffect(instance.a, parentSuspense);
				instance.isMounted = true;
				initialVNode = container = anchor = null;
			} else {
				let { next, bu, u, parent, vnode } = instance;
				{
					const nonHydratedAsyncRoot = locateNonHydratedAsyncRoot(instance);
					if (nonHydratedAsyncRoot) {
						if (next) {
							next.el = vnode.el;
							updateComponentPreRender(instance, next, optimized);
						}
						nonHydratedAsyncRoot.asyncDep.then(() => {
							if (!instance.isUnmounted) componentUpdateFn();
						});
						return;
					}
				}
				let originNext = next;
				let vnodeHook;
				toggleRecurse(instance, false);
				if (next) {
					next.el = vnode.el;
					updateComponentPreRender(instance, next, optimized);
				} else next = vnode;
				if (bu) invokeArrayFns(bu);
				if (vnodeHook = next.props && next.props.onVnodeBeforeUpdate) invokeVNodeHook(vnodeHook, parent, next, vnode);
				toggleRecurse(instance, true);
				const nextTree = renderComponentRoot(instance);
				const prevTree = instance.subTree;
				instance.subTree = nextTree;
				patch(prevTree, nextTree, hostParentNode(prevTree.el), getNextHostNode(prevTree), instance, parentSuspense, namespace);
				next.el = nextTree.el;
				if (originNext === null) updateHOCHostEl(instance, nextTree.el);
				if (u) queuePostRenderEffect(u, parentSuspense);
				if (vnodeHook = next.props && next.props.onVnodeUpdated) queuePostRenderEffect(() => invokeVNodeHook(vnodeHook, parent, next, vnode), parentSuspense);
			}
		};
		const effect = instance.effect = new ReactiveEffect(componentUpdateFn, NOOP, () => queueJob(update), instance.scope);
		const update = instance.update = () => {
			if (effect.dirty) effect.run();
		};
		update.id = instance.uid;
		toggleRecurse(instance, true);
		update();
	};
	const updateComponentPreRender = (instance, nextVNode, optimized) => {
		nextVNode.component = instance;
		const prevProps = instance.vnode.props;
		instance.vnode = nextVNode;
		instance.next = null;
		updateProps(instance, nextVNode.props, prevProps, optimized);
		updateSlots(instance, nextVNode.children, optimized);
		pauseTracking();
		flushPreFlushCbs(instance);
		resetTracking();
	};
	const patchChildren = (n1, n2, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized = false) => {
		const c1 = n1 && n1.children;
		const prevShapeFlag = n1 ? n1.shapeFlag : 0;
		const c2 = n2.children;
		const { patchFlag, shapeFlag } = n2;
		if (patchFlag > 0) {
			if (patchFlag & 128) {
				patchKeyedChildren(c1, c2, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized);
				return;
			} else if (patchFlag & 256) {
				patchUnkeyedChildren(c1, c2, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized);
				return;
			}
		}
		if (shapeFlag & 8) {
			if (prevShapeFlag & 16) unmountChildren(c1, parentComponent, parentSuspense);
			if (c2 !== c1) hostSetElementText(container, c2);
		} else if (prevShapeFlag & 16) if (shapeFlag & 16) patchKeyedChildren(c1, c2, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized);
		else unmountChildren(c1, parentComponent, parentSuspense, true);
		else {
			if (prevShapeFlag & 8) hostSetElementText(container, "");
			if (shapeFlag & 16) mountChildren(c2, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized);
		}
	};
	const patchUnkeyedChildren = (c1, c2, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized) => {
		c1 = c1 || EMPTY_ARR;
		c2 = c2 || EMPTY_ARR;
		const oldLength = c1.length;
		const newLength = c2.length;
		const commonLength = Math.min(oldLength, newLength);
		let i;
		for (i = 0; i < commonLength; i++) {
			const nextChild = c2[i] = optimized ? cloneIfMounted(c2[i]) : normalizeVNode(c2[i]);
			patch(c1[i], nextChild, container, null, parentComponent, parentSuspense, namespace, slotScopeIds, optimized);
		}
		if (oldLength > newLength) unmountChildren(c1, parentComponent, parentSuspense, true, false, commonLength);
		else mountChildren(c2, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized, commonLength);
	};
	const patchKeyedChildren = (c1, c2, container, parentAnchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized) => {
		let i = 0;
		const l2 = c2.length;
		let e1 = c1.length - 1;
		let e2 = l2 - 1;
		while (i <= e1 && i <= e2) {
			const n1 = c1[i];
			const n2 = c2[i] = optimized ? cloneIfMounted(c2[i]) : normalizeVNode(c2[i]);
			if (isSameVNodeType(n1, n2)) patch(n1, n2, container, null, parentComponent, parentSuspense, namespace, slotScopeIds, optimized);
			else break;
			i++;
		}
		while (i <= e1 && i <= e2) {
			const n1 = c1[e1];
			const n2 = c2[e2] = optimized ? cloneIfMounted(c2[e2]) : normalizeVNode(c2[e2]);
			if (isSameVNodeType(n1, n2)) patch(n1, n2, container, null, parentComponent, parentSuspense, namespace, slotScopeIds, optimized);
			else break;
			e1--;
			e2--;
		}
		if (i > e1) {
			if (i <= e2) {
				const nextPos = e2 + 1;
				const anchor = nextPos < l2 ? c2[nextPos].el : parentAnchor;
				while (i <= e2) {
					patch(null, c2[i] = optimized ? cloneIfMounted(c2[i]) : normalizeVNode(c2[i]), container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized);
					i++;
				}
			}
		} else if (i > e2) while (i <= e1) {
			unmount(c1[i], parentComponent, parentSuspense, true);
			i++;
		}
		else {
			const s1 = i;
			const s2 = i;
			const keyToNewIndexMap = /* @__PURE__ */ new Map();
			for (i = s2; i <= e2; i++) {
				const nextChild = c2[i] = optimized ? cloneIfMounted(c2[i]) : normalizeVNode(c2[i]);
				if (nextChild.key != null) keyToNewIndexMap.set(nextChild.key, i);
			}
			let j;
			let patched = 0;
			const toBePatched = e2 - s2 + 1;
			let moved = false;
			let maxNewIndexSoFar = 0;
			const newIndexToOldIndexMap = new Array(toBePatched);
			for (i = 0; i < toBePatched; i++) newIndexToOldIndexMap[i] = 0;
			for (i = s1; i <= e1; i++) {
				const prevChild = c1[i];
				if (patched >= toBePatched) {
					unmount(prevChild, parentComponent, parentSuspense, true);
					continue;
				}
				let newIndex;
				if (prevChild.key != null) newIndex = keyToNewIndexMap.get(prevChild.key);
				else for (j = s2; j <= e2; j++) if (newIndexToOldIndexMap[j - s2] === 0 && isSameVNodeType(prevChild, c2[j])) {
					newIndex = j;
					break;
				}
				if (newIndex === void 0) unmount(prevChild, parentComponent, parentSuspense, true);
				else {
					newIndexToOldIndexMap[newIndex - s2] = i + 1;
					if (newIndex >= maxNewIndexSoFar) maxNewIndexSoFar = newIndex;
					else moved = true;
					patch(prevChild, c2[newIndex], container, null, parentComponent, parentSuspense, namespace, slotScopeIds, optimized);
					patched++;
				}
			}
			const increasingNewIndexSequence = moved ? getSequence(newIndexToOldIndexMap) : EMPTY_ARR;
			j = increasingNewIndexSequence.length - 1;
			for (i = toBePatched - 1; i >= 0; i--) {
				const nextIndex = s2 + i;
				const nextChild = c2[nextIndex];
				const anchor = nextIndex + 1 < l2 ? c2[nextIndex + 1].el : parentAnchor;
				if (newIndexToOldIndexMap[i] === 0) patch(null, nextChild, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized);
				else if (moved) if (j < 0 || i !== increasingNewIndexSequence[j]) move(nextChild, container, anchor, 2);
				else j--;
			}
		}
	};
	const move = (vnode, container, anchor, moveType, parentSuspense = null) => {
		const { el, type, transition, children, shapeFlag } = vnode;
		if (shapeFlag & 6) {
			move(vnode.component.subTree, container, anchor, moveType);
			return;
		}
		if (shapeFlag & 128) {
			vnode.suspense.move(container, anchor, moveType);
			return;
		}
		if (shapeFlag & 64) {
			type.move(vnode, container, anchor, internals);
			return;
		}
		if (type === Fragment) {
			hostInsert(el, container, anchor);
			for (let i = 0; i < children.length; i++) move(children[i], container, anchor, moveType);
			hostInsert(vnode.anchor, container, anchor);
			return;
		}
		if (type === Static) {
			moveStaticNode(vnode, container, anchor);
			return;
		}
		if (moveType !== 2 && shapeFlag & 1 && transition) if (moveType === 0) {
			transition.beforeEnter(el);
			hostInsert(el, container, anchor);
			queuePostRenderEffect(() => transition.enter(el), parentSuspense);
		} else {
			const { leave, delayLeave, afterLeave } = transition;
			const remove2 = () => hostInsert(el, container, anchor);
			const performLeave = () => {
				leave(el, () => {
					remove2();
					afterLeave && afterLeave();
				});
			};
			if (delayLeave) delayLeave(el, remove2, performLeave);
			else performLeave();
		}
		else hostInsert(el, container, anchor);
	};
	const unmount = (vnode, parentComponent, parentSuspense, doRemove = false, optimized = false) => {
		const { type, props, ref, children, dynamicChildren, shapeFlag, patchFlag, dirs, memoIndex } = vnode;
		if (ref != null) setRef(ref, null, parentSuspense, vnode, true);
		if (memoIndex != null) parentComponent.renderCache[memoIndex] = void 0;
		if (shapeFlag & 256) {
			parentComponent.ctx.deactivate(vnode);
			return;
		}
		const shouldInvokeDirs = shapeFlag & 1 && dirs;
		const shouldInvokeVnodeHook = !isAsyncWrapper(vnode);
		let vnodeHook;
		if (shouldInvokeVnodeHook && (vnodeHook = props && props.onVnodeBeforeUnmount)) invokeVNodeHook(vnodeHook, parentComponent, vnode);
		if (shapeFlag & 6) unmountComponent(vnode.component, parentSuspense, doRemove);
		else {
			if (shapeFlag & 128) {
				vnode.suspense.unmount(parentSuspense, doRemove);
				return;
			}
			if (shouldInvokeDirs) invokeDirectiveHook(vnode, null, parentComponent, "beforeUnmount");
			if (shapeFlag & 64) vnode.type.remove(vnode, parentComponent, parentSuspense, optimized, internals, doRemove);
			else if (dynamicChildren && (type !== Fragment || patchFlag > 0 && patchFlag & 64)) unmountChildren(dynamicChildren, parentComponent, parentSuspense, false, true);
			else if (type === Fragment && patchFlag & 384 || !optimized && shapeFlag & 16) unmountChildren(children, parentComponent, parentSuspense);
			if (doRemove) remove(vnode);
		}
		if (shouldInvokeVnodeHook && (vnodeHook = props && props.onVnodeUnmounted) || shouldInvokeDirs) queuePostRenderEffect(() => {
			vnodeHook && invokeVNodeHook(vnodeHook, parentComponent, vnode);
			shouldInvokeDirs && invokeDirectiveHook(vnode, null, parentComponent, "unmounted");
		}, parentSuspense);
	};
	const remove = (vnode) => {
		const { type, el, anchor, transition } = vnode;
		if (type === Fragment) {
			removeFragment(el, anchor);
			return;
		}
		if (type === Static) {
			removeStaticNode(vnode);
			return;
		}
		const performRemove = () => {
			hostRemove(el);
			if (transition && !transition.persisted && transition.afterLeave) transition.afterLeave();
		};
		if (vnode.shapeFlag & 1 && transition && !transition.persisted) {
			const { leave, delayLeave } = transition;
			const performLeave = () => leave(el, performRemove);
			if (delayLeave) delayLeave(vnode.el, performRemove, performLeave);
			else performLeave();
		} else performRemove();
	};
	const removeFragment = (cur, end) => {
		let next;
		while (cur !== end) {
			next = hostNextSibling(cur);
			hostRemove(cur);
			cur = next;
		}
		hostRemove(end);
	};
	const unmountComponent = (instance, parentSuspense, doRemove) => {
		const { bum, scope, update, subTree, um, m, a } = instance;
		invalidateMount(m);
		invalidateMount(a);
		if (bum) invokeArrayFns(bum);
		scope.stop();
		if (update) {
			update.active = false;
			unmount(subTree, instance, parentSuspense, doRemove);
		}
		if (um) queuePostRenderEffect(um, parentSuspense);
		queuePostRenderEffect(() => {
			instance.isUnmounted = true;
		}, parentSuspense);
		if (parentSuspense && parentSuspense.pendingBranch && !parentSuspense.isUnmounted && instance.asyncDep && !instance.asyncResolved && instance.suspenseId === parentSuspense.pendingId) {
			parentSuspense.deps--;
			if (parentSuspense.deps === 0) parentSuspense.resolve();
		}
	};
	const unmountChildren = (children, parentComponent, parentSuspense, doRemove = false, optimized = false, start = 0) => {
		for (let i = start; i < children.length; i++) unmount(children[i], parentComponent, parentSuspense, doRemove, optimized);
	};
	const getNextHostNode = (vnode) => {
		if (vnode.shapeFlag & 6) return getNextHostNode(vnode.component.subTree);
		if (vnode.shapeFlag & 128) return vnode.suspense.next();
		return hostNextSibling(vnode.anchor || vnode.el);
	};
	let isFlushing = false;
	const render = (vnode, container, namespace) => {
		if (vnode == null) {
			if (container._vnode) unmount(container._vnode, null, null, true);
		} else patch(container._vnode || null, vnode, container, null, null, null, namespace);
		if (!isFlushing) {
			isFlushing = true;
			flushPreFlushCbs();
			flushPostFlushCbs();
			isFlushing = false;
		}
		container._vnode = vnode;
	};
	const internals = {
		p: patch,
		um: unmount,
		m: move,
		r: remove,
		mt: mountComponent,
		mc: mountChildren,
		pc: patchChildren,
		pbc: patchBlockChildren,
		n: getNextHostNode,
		o: options
	};
	let hydrate;
	let hydrateNode;
	if (createHydrationFns) [hydrate, hydrateNode] = createHydrationFns(internals);
	return {
		render,
		hydrate,
		createApp: createAppAPI(render, hydrate)
	};
}
function resolveChildrenNamespace({ type, props }, currentNamespace) {
	return currentNamespace === "svg" && type === "foreignObject" || currentNamespace === "mathml" && type === "annotation-xml" && props && props.encoding && props.encoding.includes("html") ? void 0 : currentNamespace;
}
function toggleRecurse({ effect, update }, allowed) {
	effect.allowRecurse = update.allowRecurse = allowed;
}
function needTransition(parentSuspense, transition) {
	return (!parentSuspense || parentSuspense && !parentSuspense.pendingBranch) && transition && !transition.persisted;
}
function traverseStaticChildren(n1, n2, shallow = false) {
	const ch1 = n1.children;
	const ch2 = n2.children;
	if (isArray$1(ch1) && isArray$1(ch2)) for (let i = 0; i < ch1.length; i++) {
		const c1 = ch1[i];
		let c2 = ch2[i];
		if (c2.shapeFlag & 1 && !c2.dynamicChildren) {
			if (c2.patchFlag <= 0 || c2.patchFlag === 32) {
				c2 = ch2[i] = cloneIfMounted(ch2[i]);
				c2.el = c1.el;
			}
			if (!shallow && c2.patchFlag !== -2) traverseStaticChildren(c1, c2);
		}
		if (c2.type === Text) c2.el = c1.el;
	}
}
function getSequence(arr) {
	const p = arr.slice();
	const result = [0];
	let i, j, u, v, c;
	const len = arr.length;
	for (i = 0; i < len; i++) {
		const arrI = arr[i];
		if (arrI !== 0) {
			j = result[result.length - 1];
			if (arr[j] < arrI) {
				p[i] = j;
				result.push(i);
				continue;
			}
			u = 0;
			v = result.length - 1;
			while (u < v) {
				c = u + v >> 1;
				if (arr[result[c]] < arrI) u = c + 1;
				else v = c;
			}
			if (arrI < arr[result[u]]) {
				if (u > 0) p[i] = result[u - 1];
				result[u] = i;
			}
		}
	}
	u = result.length;
	v = result[u - 1];
	while (u-- > 0) {
		result[u] = v;
		v = p[v];
	}
	return result;
}
function locateNonHydratedAsyncRoot(instance) {
	const subComponent = instance.subTree.component;
	if (subComponent) if (subComponent.asyncDep && !subComponent.asyncResolved) return subComponent;
	else return locateNonHydratedAsyncRoot(subComponent);
}
function invalidateMount(hooks) {
	if (hooks) for (let i = 0; i < hooks.length; i++) hooks[i].active = false;
}
var ssrContextKey = Symbol.for("v-scx");
var useSSRContext = () => {
	{
		const ctx = inject(ssrContextKey);
		if (!ctx) {}
		return ctx;
	}
};
function watchEffect(effect, options) {
	return doWatch(effect, null, options);
}
function watchPostEffect(effect, options) {
	return doWatch(effect, null, { flush: "post" });
}
function watchSyncEffect(effect, options) {
	return doWatch(effect, null, { flush: "sync" });
}
var INITIAL_WATCHER_VALUE = {};
function watch(source, cb, options) {
	return doWatch(source, cb, options);
}
function doWatch(source, cb, { immediate, deep, flush, once, onTrack, onTrigger } = EMPTY_OBJ) {
	if (cb && once) {
		const _cb = cb;
		cb = (...args) => {
			_cb(...args);
			unwatch();
		};
	}
	const instance = currentInstance;
	const reactiveGetter = (source2) => deep === true ? source2 : traverse(source2, deep === false ? 1 : void 0);
	let getter;
	let forceTrigger = false;
	let isMultiSource = false;
	if (isRef(source)) {
		getter = () => source.value;
		forceTrigger = isShallow(source);
	} else if (isReactive(source)) {
		getter = () => reactiveGetter(source);
		forceTrigger = true;
	} else if (isArray$1(source)) {
		isMultiSource = true;
		forceTrigger = source.some((s) => isReactive(s) || isShallow(s));
		getter = () => source.map((s) => {
			if (isRef(s)) return s.value;
			else if (isReactive(s)) return reactiveGetter(s);
			else if (isFunction(s)) return callWithErrorHandling(s, instance, 2);
		});
	} else if (isFunction(source)) if (cb) getter = () => callWithErrorHandling(source, instance, 2);
	else getter = () => {
		if (cleanup) cleanup();
		return callWithAsyncErrorHandling(source, instance, 3, [onCleanup]);
	};
	else getter = NOOP;
	if (cb && deep) {
		const baseGetter = getter;
		getter = () => traverse(baseGetter());
	}
	let cleanup;
	let onCleanup = (fn) => {
		cleanup = effect.onStop = () => {
			callWithErrorHandling(fn, instance, 4);
			cleanup = effect.onStop = void 0;
		};
	};
	let ssrCleanup;
	if (isInSSRComponentSetup) {
		onCleanup = NOOP;
		if (!cb) getter();
		else if (immediate) callWithAsyncErrorHandling(cb, instance, 3, [
			getter(),
			isMultiSource ? [] : void 0,
			onCleanup
		]);
		if (flush === "sync") {
			const ctx = useSSRContext();
			ssrCleanup = ctx.__watcherHandles || (ctx.__watcherHandles = []);
		} else return NOOP;
	}
	let oldValue = isMultiSource ? new Array(source.length).fill(INITIAL_WATCHER_VALUE) : INITIAL_WATCHER_VALUE;
	const job = () => {
		if (!effect.active || !effect.dirty) return;
		if (cb) {
			const newValue = effect.run();
			if (deep || forceTrigger || (isMultiSource ? newValue.some((v, i) => hasChanged(v, oldValue[i])) : hasChanged(newValue, oldValue)) || false) {
				if (cleanup) cleanup();
				callWithAsyncErrorHandling(cb, instance, 3, [
					newValue,
					oldValue === INITIAL_WATCHER_VALUE ? void 0 : isMultiSource && oldValue[0] === INITIAL_WATCHER_VALUE ? [] : oldValue,
					onCleanup
				]);
				oldValue = newValue;
			}
		} else effect.run();
	};
	job.allowRecurse = !!cb;
	let scheduler;
	if (flush === "sync") scheduler = job;
	else if (flush === "post") scheduler = () => queuePostRenderEffect(job, instance && instance.suspense);
	else {
		job.pre = true;
		if (instance) job.id = instance.uid;
		scheduler = () => queueJob(job);
	}
	const effect = new ReactiveEffect(getter, NOOP, scheduler);
	const scope = getCurrentScope();
	const unwatch = () => {
		effect.stop();
		if (scope) remove(scope.effects, effect);
	};
	if (cb) if (immediate) job();
	else oldValue = effect.run();
	else if (flush === "post") queuePostRenderEffect(effect.run.bind(effect), instance && instance.suspense);
	else effect.run();
	if (ssrCleanup) ssrCleanup.push(unwatch);
	return unwatch;
}
function instanceWatch(source, value, options) {
	const publicThis = this.proxy;
	const getter = isString(source) ? source.includes(".") ? createPathGetter(publicThis, source) : () => publicThis[source] : source.bind(publicThis, publicThis);
	let cb;
	if (isFunction(value)) cb = value;
	else {
		cb = value.handler;
		options = value;
	}
	const reset = setCurrentInstance(this);
	const res = doWatch(getter, cb.bind(publicThis), options);
	reset();
	return res;
}
function createPathGetter(ctx, path) {
	const segments = path.split(".");
	return () => {
		let cur = ctx;
		for (let i = 0; i < segments.length && cur; i++) cur = cur[segments[i]];
		return cur;
	};
}
function traverse(value, depth = Infinity, seen) {
	if (depth <= 0 || !isObject(value) || value["__v_skip"]) return value;
	seen = seen || /* @__PURE__ */ new Set();
	if (seen.has(value)) return value;
	seen.add(value);
	depth--;
	if (isRef(value)) traverse(value.value, depth, seen);
	else if (isArray$1(value)) for (let i = 0; i < value.length; i++) traverse(value[i], depth, seen);
	else if (isSet(value) || isMap(value)) value.forEach((v) => {
		traverse(v, depth, seen);
	});
	else if (isPlainObject(value)) {
		for (const key in value) traverse(value[key], depth, seen);
		for (const key of Object.getOwnPropertySymbols(value)) if (Object.prototype.propertyIsEnumerable.call(value, key)) traverse(value[key], depth, seen);
	}
	return value;
}
var isKeepAlive = (vnode) => vnode.type.__isKeepAlive;
var KeepAlive = {
	name: `KeepAlive`,
	__isKeepAlive: true,
	props: {
		include: [
			String,
			RegExp,
			Array
		],
		exclude: [
			String,
			RegExp,
			Array
		],
		max: [String, Number]
	},
	setup(props, { slots }) {
		const instance = getCurrentInstance();
		const sharedContext = instance.ctx;
		if (!sharedContext.renderer) return () => {
			const children = slots.default && slots.default();
			return children && children.length === 1 ? children[0] : children;
		};
		const cache = /* @__PURE__ */ new Map();
		const keys = /* @__PURE__ */ new Set();
		let current = null;
		const parentSuspense = instance.suspense;
		const { renderer: { p: patch, m: move, um: _unmount, o: { createElement } } } = sharedContext;
		const storageContainer = createElement("div");
		sharedContext.activate = (vnode, container, anchor, namespace, optimized) => {
			const instance2 = vnode.component;
			move(vnode, container, anchor, 0, parentSuspense);
			patch(instance2.vnode, vnode, container, anchor, instance2, parentSuspense, namespace, vnode.slotScopeIds, optimized);
			queuePostRenderEffect(() => {
				instance2.isDeactivated = false;
				if (instance2.a) invokeArrayFns(instance2.a);
				const vnodeHook = vnode.props && vnode.props.onVnodeMounted;
				if (vnodeHook) invokeVNodeHook(vnodeHook, instance2.parent, vnode);
			}, parentSuspense);
		};
		sharedContext.deactivate = (vnode) => {
			const instance2 = vnode.component;
			invalidateMount(instance2.m);
			invalidateMount(instance2.a);
			move(vnode, storageContainer, null, 1, parentSuspense);
			queuePostRenderEffect(() => {
				if (instance2.da) invokeArrayFns(instance2.da);
				const vnodeHook = vnode.props && vnode.props.onVnodeUnmounted;
				if (vnodeHook) invokeVNodeHook(vnodeHook, instance2.parent, vnode);
				instance2.isDeactivated = true;
			}, parentSuspense);
		};
		function unmount(vnode) {
			resetShapeFlag(vnode);
			_unmount(vnode, instance, parentSuspense, true);
		}
		function pruneCache(filter) {
			cache.forEach((vnode, key) => {
				const name = getComponentName(vnode.type);
				if (name && (!filter || !filter(name))) pruneCacheEntry(key);
			});
		}
		function pruneCacheEntry(key) {
			const cached = cache.get(key);
			if (!current || !isSameVNodeType(cached, current)) unmount(cached);
			else if (current) resetShapeFlag(current);
			cache.delete(key);
			keys.delete(key);
		}
		watch(() => [props.include, props.exclude], ([include, exclude]) => {
			include && pruneCache((name) => matches(include, name));
			exclude && pruneCache((name) => !matches(exclude, name));
		}, {
			flush: "post",
			deep: true
		});
		let pendingCacheKey = null;
		const cacheSubtree = () => {
			if (pendingCacheKey != null) if (isSuspense(instance.subTree.type)) queuePostRenderEffect(() => {
				cache.set(pendingCacheKey, getInnerChild(instance.subTree));
			}, instance.subTree.suspense);
			else cache.set(pendingCacheKey, getInnerChild(instance.subTree));
		};
		onMounted(cacheSubtree);
		onUpdated(cacheSubtree);
		onBeforeUnmount(() => {
			cache.forEach((cached) => {
				const { subTree, suspense } = instance;
				const vnode = getInnerChild(subTree);
				if (cached.type === vnode.type && cached.key === vnode.key) {
					resetShapeFlag(vnode);
					const da = vnode.component.da;
					da && queuePostRenderEffect(da, suspense);
					return;
				}
				unmount(cached);
			});
		});
		return () => {
			pendingCacheKey = null;
			if (!slots.default) return null;
			const children = slots.default();
			const rawVNode = children[0];
			if (children.length > 1) {
				current = null;
				return children;
			} else if (!isVNode(rawVNode) || !(rawVNode.shapeFlag & 4) && !(rawVNode.shapeFlag & 128)) {
				current = null;
				return rawVNode;
			}
			let vnode = getInnerChild(rawVNode);
			const comp = vnode.type;
			const name = getComponentName(isAsyncWrapper(vnode) ? vnode.type.__asyncResolved || {} : comp);
			const { include, exclude, max } = props;
			if (include && (!name || !matches(include, name)) || exclude && name && matches(exclude, name)) {
				current = vnode;
				return rawVNode;
			}
			const key = vnode.key == null ? comp : vnode.key;
			const cachedVNode = cache.get(key);
			if (vnode.el) {
				vnode = cloneVNode(vnode);
				if (rawVNode.shapeFlag & 128) rawVNode.ssContent = vnode;
			}
			pendingCacheKey = key;
			if (cachedVNode) {
				vnode.el = cachedVNode.el;
				vnode.component = cachedVNode.component;
				if (vnode.transition) setTransitionHooks(vnode, vnode.transition);
				vnode.shapeFlag |= 512;
				keys.delete(key);
				keys.add(key);
			} else {
				keys.add(key);
				if (max && keys.size > parseInt(max, 10)) pruneCacheEntry(keys.values().next().value);
			}
			vnode.shapeFlag |= 256;
			current = vnode;
			return isSuspense(rawVNode.type) ? rawVNode : vnode;
		};
	}
};
function matches(pattern, name) {
	if (isArray$1(pattern)) return pattern.some((p) => matches(p, name));
	else if (isString(pattern)) return pattern.split(",").includes(name);
	else if (isRegExp(pattern)) return pattern.test(name);
	return false;
}
function onActivated(hook, target) {
	registerKeepAliveHook(hook, "a", target);
}
function onDeactivated(hook, target) {
	registerKeepAliveHook(hook, "da", target);
}
function registerKeepAliveHook(hook, type, target = currentInstance) {
	const wrappedHook = hook.__wdc || (hook.__wdc = () => {
		let current = target;
		while (current) {
			if (current.isDeactivated) return;
			current = current.parent;
		}
		return hook();
	});
	injectHook(type, wrappedHook, target);
	if (target) {
		let current = target.parent;
		while (current && current.parent) {
			if (isKeepAlive(current.parent.vnode)) injectToKeepAliveRoot(wrappedHook, type, target, current);
			current = current.parent;
		}
	}
}
function injectToKeepAliveRoot(hook, type, target, keepAliveRoot) {
	const injected = injectHook(type, hook, keepAliveRoot, true);
	onUnmounted(() => {
		remove(keepAliveRoot[type], injected);
	}, target);
}
function resetShapeFlag(vnode) {
	vnode.shapeFlag &= -257;
	vnode.shapeFlag &= -513;
}
function getInnerChild(vnode) {
	return vnode.shapeFlag & 128 ? vnode.ssContent : vnode;
}
var leaveCbKey = Symbol("_leaveCb");
var enterCbKey$1 = Symbol("_enterCb");
function useTransitionState() {
	const state = {
		isMounted: false,
		isLeaving: false,
		isUnmounting: false,
		leavingVNodes: /* @__PURE__ */ new Map()
	};
	onMounted(() => {
		state.isMounted = true;
	});
	onBeforeUnmount(() => {
		state.isUnmounting = true;
	});
	return state;
}
var TransitionHookValidator = [Function, Array];
var BaseTransitionPropsValidators = {
	mode: String,
	appear: Boolean,
	persisted: Boolean,
	onBeforeEnter: TransitionHookValidator,
	onEnter: TransitionHookValidator,
	onAfterEnter: TransitionHookValidator,
	onEnterCancelled: TransitionHookValidator,
	onBeforeLeave: TransitionHookValidator,
	onLeave: TransitionHookValidator,
	onAfterLeave: TransitionHookValidator,
	onLeaveCancelled: TransitionHookValidator,
	onBeforeAppear: TransitionHookValidator,
	onAppear: TransitionHookValidator,
	onAfterAppear: TransitionHookValidator,
	onAppearCancelled: TransitionHookValidator
};
var recursiveGetSubtree = (instance) => {
	const subTree = instance.subTree;
	return subTree.component ? recursiveGetSubtree(subTree.component) : subTree;
};
var BaseTransition = {
	name: `BaseTransition`,
	props: BaseTransitionPropsValidators,
	setup(props, { slots }) {
		const instance = getCurrentInstance();
		const state = useTransitionState();
		return () => {
			const children = slots.default && getTransitionRawChildren(slots.default(), true);
			if (!children || !children.length) return;
			let child = children[0];
			if (children.length > 1) {
				for (const c of children) if (c.type !== Comment) {
					child = c;
					break;
				}
			}
			const rawProps = toRaw(props);
			const { mode } = rawProps;
			if (state.isLeaving) return emptyPlaceholder(child);
			const innerChild = getKeepAliveChild(child);
			if (!innerChild) return emptyPlaceholder(child);
			let enterHooks = resolveTransitionHooks(innerChild, rawProps, state, instance, (hooks) => enterHooks = hooks);
			setTransitionHooks(innerChild, enterHooks);
			const oldChild = instance.subTree;
			const oldInnerChild = oldChild && getKeepAliveChild(oldChild);
			if (oldInnerChild && oldInnerChild.type !== Comment && !isSameVNodeType(innerChild, oldInnerChild) && recursiveGetSubtree(instance).type !== Comment) {
				const leavingHooks = resolveTransitionHooks(oldInnerChild, rawProps, state, instance);
				setTransitionHooks(oldInnerChild, leavingHooks);
				if (mode === "out-in" && innerChild.type !== Comment) {
					state.isLeaving = true;
					leavingHooks.afterLeave = () => {
						state.isLeaving = false;
						if (instance.update.active !== false) {
							instance.effect.dirty = true;
							instance.update();
						}
					};
					return emptyPlaceholder(child);
				} else if (mode === "in-out" && innerChild.type !== Comment) leavingHooks.delayLeave = (el, earlyRemove, delayedLeave) => {
					const leavingVNodesCache = getLeavingNodesForType(state, oldInnerChild);
					leavingVNodesCache[String(oldInnerChild.key)] = oldInnerChild;
					el[leaveCbKey] = () => {
						earlyRemove();
						el[leaveCbKey] = void 0;
						delete enterHooks.delayedLeave;
					};
					enterHooks.delayedLeave = delayedLeave;
				};
			}
			return child;
		};
	}
};
function getLeavingNodesForType(state, vnode) {
	const { leavingVNodes } = state;
	let leavingVNodesCache = leavingVNodes.get(vnode.type);
	if (!leavingVNodesCache) {
		leavingVNodesCache = /* @__PURE__ */ Object.create(null);
		leavingVNodes.set(vnode.type, leavingVNodesCache);
	}
	return leavingVNodesCache;
}
function resolveTransitionHooks(vnode, props, state, instance, postClone) {
	const { appear, mode, persisted = false, onBeforeEnter, onEnter, onAfterEnter, onEnterCancelled, onBeforeLeave, onLeave, onAfterLeave, onLeaveCancelled, onBeforeAppear, onAppear, onAfterAppear, onAppearCancelled } = props;
	const key = String(vnode.key);
	const leavingVNodesCache = getLeavingNodesForType(state, vnode);
	const callHook = (hook, args) => {
		hook && callWithAsyncErrorHandling(hook, instance, 9, args);
	};
	const callAsyncHook = (hook, args) => {
		const done = args[1];
		callHook(hook, args);
		if (isArray$1(hook)) {
			if (hook.every((hook2) => hook2.length <= 1)) done();
		} else if (hook.length <= 1) done();
	};
	const hooks = {
		mode,
		persisted,
		beforeEnter(el) {
			let hook = onBeforeEnter;
			if (!state.isMounted) if (appear) hook = onBeforeAppear || onBeforeEnter;
			else return;
			if (el[leaveCbKey]) el[leaveCbKey](true);
			const leavingVNode = leavingVNodesCache[key];
			if (leavingVNode && isSameVNodeType(vnode, leavingVNode) && leavingVNode.el[leaveCbKey]) leavingVNode.el[leaveCbKey]();
			callHook(hook, [el]);
		},
		enter(el) {
			let hook = onEnter;
			let afterHook = onAfterEnter;
			let cancelHook = onEnterCancelled;
			if (!state.isMounted) if (appear) {
				hook = onAppear || onEnter;
				afterHook = onAfterAppear || onAfterEnter;
				cancelHook = onAppearCancelled || onEnterCancelled;
			} else return;
			let called = false;
			const done = el[enterCbKey$1] = (cancelled) => {
				if (called) return;
				called = true;
				if (cancelled) callHook(cancelHook, [el]);
				else callHook(afterHook, [el]);
				if (hooks.delayedLeave) hooks.delayedLeave();
				el[enterCbKey$1] = void 0;
			};
			if (hook) callAsyncHook(hook, [el, done]);
			else done();
		},
		leave(el, remove) {
			const key2 = String(vnode.key);
			if (el[enterCbKey$1]) el[enterCbKey$1](true);
			if (state.isUnmounting) return remove();
			callHook(onBeforeLeave, [el]);
			let called = false;
			const done = el[leaveCbKey] = (cancelled) => {
				if (called) return;
				called = true;
				remove();
				if (cancelled) callHook(onLeaveCancelled, [el]);
				else callHook(onAfterLeave, [el]);
				el[leaveCbKey] = void 0;
				if (leavingVNodesCache[key2] === vnode) delete leavingVNodesCache[key2];
			};
			leavingVNodesCache[key2] = vnode;
			if (onLeave) callAsyncHook(onLeave, [el, done]);
			else done();
		},
		clone(vnode2) {
			const hooks2 = resolveTransitionHooks(vnode2, props, state, instance, postClone);
			if (postClone) postClone(hooks2);
			return hooks2;
		}
	};
	return hooks;
}
function emptyPlaceholder(vnode) {
	if (isKeepAlive(vnode)) {
		vnode = cloneVNode(vnode);
		vnode.children = null;
		return vnode;
	}
}
function getKeepAliveChild(vnode) {
	if (!isKeepAlive(vnode)) return vnode;
	const { shapeFlag, children } = vnode;
	if (children) {
		if (shapeFlag & 16) return children[0];
		if (shapeFlag & 32 && isFunction(children.default)) return children.default();
	}
}
function setTransitionHooks(vnode, hooks) {
	if (vnode.shapeFlag & 6 && vnode.component) setTransitionHooks(vnode.component.subTree, hooks);
	else if (vnode.shapeFlag & 128) {
		vnode.ssContent.transition = hooks.clone(vnode.ssContent);
		vnode.ssFallback.transition = hooks.clone(vnode.ssFallback);
	} else vnode.transition = hooks;
}
function getTransitionRawChildren(children, keepComment = false, parentKey) {
	let ret = [];
	let keyedFragmentCount = 0;
	for (let i = 0; i < children.length; i++) {
		let child = children[i];
		const key = parentKey == null ? child.key : String(parentKey) + String(child.key != null ? child.key : i);
		if (child.type === Fragment) {
			if (child.patchFlag & 128) keyedFragmentCount++;
			ret = ret.concat(getTransitionRawChildren(child.children, keepComment, key));
		} else if (keepComment || child.type !== Comment) ret.push(key != null ? cloneVNode(child, { key }) : child);
	}
	if (keyedFragmentCount > 1) for (let i = 0; i < ret.length; i++) ret[i].patchFlag = -2;
	return ret;
}
var isTeleport = (type) => type.__isTeleport;
var isTeleportDisabled = (props) => props && (props.disabled || props.disabled === "");
var isTargetSVG = (target) => typeof SVGElement !== "undefined" && target instanceof SVGElement;
var isTargetMathML = (target) => typeof MathMLElement === "function" && target instanceof MathMLElement;
var resolveTarget = (props, select) => {
	const targetSelector = props && props.to;
	if (isString(targetSelector)) if (!select) return null;
	else return select(targetSelector);
	else return targetSelector;
};
var TeleportImpl = {
	name: "Teleport",
	__isTeleport: true,
	process(n1, n2, container, anchor, parentComponent, parentSuspense, namespace, slotScopeIds, optimized, internals) {
		const { mc: mountChildren, pc: patchChildren, pbc: patchBlockChildren, o: { insert, querySelector, createText, createComment } } = internals;
		const disabled = isTeleportDisabled(n2.props);
		let { shapeFlag, children, dynamicChildren } = n2;
		if (n1 == null) {
			const placeholder = n2.el = createText("");
			const mainAnchor = n2.anchor = createText("");
			insert(placeholder, container, anchor);
			insert(mainAnchor, container, anchor);
			const target = n2.target = resolveTarget(n2.props, querySelector);
			const targetAnchor = n2.targetAnchor = createText("");
			if (target) {
				insert(targetAnchor, target);
				if (namespace === "svg" || isTargetSVG(target)) namespace = "svg";
				else if (namespace === "mathml" || isTargetMathML(target)) namespace = "mathml";
			}
			const mount = (container2, anchor2) => {
				if (shapeFlag & 16) mountChildren(children, container2, anchor2, parentComponent, parentSuspense, namespace, slotScopeIds, optimized);
			};
			if (disabled) mount(container, mainAnchor);
			else if (target) mount(target, targetAnchor);
		} else {
			n2.el = n1.el;
			const mainAnchor = n2.anchor = n1.anchor;
			const target = n2.target = n1.target;
			const targetAnchor = n2.targetAnchor = n1.targetAnchor;
			const wasDisabled = isTeleportDisabled(n1.props);
			const currentContainer = wasDisabled ? container : target;
			const currentAnchor = wasDisabled ? mainAnchor : targetAnchor;
			if (namespace === "svg" || isTargetSVG(target)) namespace = "svg";
			else if (namespace === "mathml" || isTargetMathML(target)) namespace = "mathml";
			if (dynamicChildren) {
				patchBlockChildren(n1.dynamicChildren, dynamicChildren, currentContainer, parentComponent, parentSuspense, namespace, slotScopeIds);
				traverseStaticChildren(n1, n2, true);
			} else if (!optimized) patchChildren(n1, n2, currentContainer, currentAnchor, parentComponent, parentSuspense, namespace, slotScopeIds, false);
			if (disabled) {
				if (!wasDisabled) moveTeleport(n2, container, mainAnchor, internals, 1);
				else if (n2.props && n1.props && n2.props.to !== n1.props.to) n2.props.to = n1.props.to;
			} else if ((n2.props && n2.props.to) !== (n1.props && n1.props.to)) {
				const nextTarget = n2.target = resolveTarget(n2.props, querySelector);
				if (nextTarget) moveTeleport(n2, nextTarget, null, internals, 0);
			} else if (wasDisabled) moveTeleport(n2, target, targetAnchor, internals, 1);
		}
		updateCssVars(n2);
	},
	remove(vnode, parentComponent, parentSuspense, optimized, { um: unmount, o: { remove: hostRemove } }, doRemove) {
		const { shapeFlag, children, anchor, targetAnchor, target, props } = vnode;
		if (target) hostRemove(targetAnchor);
		doRemove && hostRemove(anchor);
		if (shapeFlag & 16) {
			const shouldRemove = doRemove || !isTeleportDisabled(props);
			for (let i = 0; i < children.length; i++) {
				const child = children[i];
				unmount(child, parentComponent, parentSuspense, shouldRemove, !!child.dynamicChildren);
			}
		}
	},
	move: moveTeleport,
	hydrate: hydrateTeleport
};
function moveTeleport(vnode, container, parentAnchor, { o: { insert }, m: move }, moveType = 2) {
	if (moveType === 0) insert(vnode.targetAnchor, container, parentAnchor);
	const { el, anchor, shapeFlag, children, props } = vnode;
	const isReorder = moveType === 2;
	if (isReorder) insert(el, container, parentAnchor);
	if (!isReorder || isTeleportDisabled(props)) {
		if (shapeFlag & 16) for (let i = 0; i < children.length; i++) move(children[i], container, parentAnchor, 2);
	}
	if (isReorder) insert(anchor, container, parentAnchor);
}
function hydrateTeleport(node, vnode, parentComponent, parentSuspense, slotScopeIds, optimized, { o: { nextSibling, parentNode, querySelector } }, hydrateChildren) {
	const target = vnode.target = resolveTarget(vnode.props, querySelector);
	if (target) {
		const targetNode = target._lpa || target.firstChild;
		if (vnode.shapeFlag & 16) if (isTeleportDisabled(vnode.props)) {
			vnode.anchor = hydrateChildren(nextSibling(node), vnode, parentNode(node), parentComponent, parentSuspense, slotScopeIds, optimized);
			vnode.targetAnchor = targetNode;
		} else {
			vnode.anchor = nextSibling(node);
			let targetAnchor = targetNode;
			while (targetAnchor) {
				targetAnchor = nextSibling(targetAnchor);
				if (targetAnchor && targetAnchor.nodeType === 8 && targetAnchor.data === "teleport anchor") {
					vnode.targetAnchor = targetAnchor;
					target._lpa = vnode.targetAnchor && nextSibling(vnode.targetAnchor);
					break;
				}
			}
			hydrateChildren(targetNode, vnode, target, parentComponent, parentSuspense, slotScopeIds, optimized);
		}
		updateCssVars(vnode);
	}
	return vnode.anchor && nextSibling(vnode.anchor);
}
var Teleport = TeleportImpl;
function updateCssVars(vnode) {
	const ctx = vnode.ctx;
	if (ctx && ctx.ut) {
		let node = vnode.children[0].el;
		while (node && node !== vnode.targetAnchor) {
			if (node.nodeType === 1) node.setAttribute("data-v-owner", ctx.uid);
			node = node.nextSibling;
		}
		ctx.ut();
	}
}
var Fragment = Symbol.for("v-fgt");
var Text = Symbol.for("v-txt");
var Comment = Symbol.for("v-cmt");
var Static = Symbol.for("v-stc");
var blockStack = [];
var currentBlock = null;
function openBlock(disableTracking = false) {
	blockStack.push(currentBlock = disableTracking ? null : []);
}
function closeBlock() {
	blockStack.pop();
	currentBlock = blockStack[blockStack.length - 1] || null;
}
var isBlockTreeEnabled = 1;
function setBlockTracking(value) {
	isBlockTreeEnabled += value;
}
function setupBlock(vnode) {
	vnode.dynamicChildren = isBlockTreeEnabled > 0 ? currentBlock || EMPTY_ARR : null;
	closeBlock();
	if (isBlockTreeEnabled > 0 && currentBlock) currentBlock.push(vnode);
	return vnode;
}
function createElementBlock(type, props, children, patchFlag, dynamicProps, shapeFlag) {
	return setupBlock(createBaseVNode(type, props, children, patchFlag, dynamicProps, shapeFlag, true));
}
function createBlock(type, props, children, patchFlag, dynamicProps) {
	return setupBlock(createVNode(type, props, children, patchFlag, dynamicProps, true));
}
function isVNode(value) {
	return value ? value.__v_isVNode === true : false;
}
function isSameVNodeType(n1, n2) {
	return n1.type === n2.type && n1.key === n2.key;
}
function transformVNodeArgs(transformer) {}
var normalizeKey = ({ key }) => key != null ? key : null;
var normalizeRef = ({ ref, ref_key, ref_for }) => {
	if (typeof ref === "number") ref = "" + ref;
	return ref != null ? isString(ref) || isRef(ref) || isFunction(ref) ? {
		i: currentRenderingInstance,
		r: ref,
		k: ref_key,
		f: !!ref_for
	} : ref : null;
};
function createBaseVNode(type, props = null, children = null, patchFlag = 0, dynamicProps = null, shapeFlag = type === Fragment ? 0 : 1, isBlockNode = false, needFullChildrenNormalization = false) {
	const vnode = {
		__v_isVNode: true,
		__v_skip: true,
		type,
		props,
		key: props && normalizeKey(props),
		ref: props && normalizeRef(props),
		scopeId: currentScopeId,
		slotScopeIds: null,
		children,
		component: null,
		suspense: null,
		ssContent: null,
		ssFallback: null,
		dirs: null,
		transition: null,
		el: null,
		anchor: null,
		target: null,
		targetAnchor: null,
		staticCount: 0,
		shapeFlag,
		patchFlag,
		dynamicProps,
		dynamicChildren: null,
		appContext: null,
		ctx: currentRenderingInstance
	};
	if (needFullChildrenNormalization) {
		normalizeChildren(vnode, children);
		if (shapeFlag & 128) type.normalize(vnode);
	} else if (children) vnode.shapeFlag |= isString(children) ? 8 : 16;
	if (isBlockTreeEnabled > 0 && !isBlockNode && currentBlock && (vnode.patchFlag > 0 || shapeFlag & 6) && vnode.patchFlag !== 32) currentBlock.push(vnode);
	return vnode;
}
var createVNode = _createVNode;
function _createVNode(type, props = null, children = null, patchFlag = 0, dynamicProps = null, isBlockNode = false) {
	if (!type || type === NULL_DYNAMIC_COMPONENT) type = Comment;
	if (isVNode(type)) {
		const cloned = cloneVNode(type, props, true);
		if (children) normalizeChildren(cloned, children);
		if (isBlockTreeEnabled > 0 && !isBlockNode && currentBlock) if (cloned.shapeFlag & 6) currentBlock[currentBlock.indexOf(type)] = cloned;
		else currentBlock.push(cloned);
		cloned.patchFlag = -2;
		return cloned;
	}
	if (isClassComponent(type)) type = type.__vccOpts;
	if (props) {
		props = guardReactiveProps(props);
		let { class: klass, style } = props;
		if (klass && !isString(klass)) props.class = normalizeClass(klass);
		if (isObject(style)) {
			if (isProxy(style) && !isArray$1(style)) style = extend({}, style);
			props.style = normalizeStyle(style);
		}
	}
	const shapeFlag = isString(type) ? 1 : isSuspense(type) ? 128 : isTeleport(type) ? 64 : isObject(type) ? 4 : isFunction(type) ? 2 : 0;
	return createBaseVNode(type, props, children, patchFlag, dynamicProps, shapeFlag, isBlockNode, true);
}
function guardReactiveProps(props) {
	if (!props) return null;
	return isProxy(props) || isInternalObject(props) ? extend({}, props) : props;
}
function cloneVNode(vnode, extraProps, mergeRef = false, cloneTransition = false) {
	const { props, ref, patchFlag, children, transition } = vnode;
	const mergedProps = extraProps ? mergeProps(props || {}, extraProps) : props;
	const cloned = {
		__v_isVNode: true,
		__v_skip: true,
		type: vnode.type,
		props: mergedProps,
		key: mergedProps && normalizeKey(mergedProps),
		ref: extraProps && extraProps.ref ? mergeRef && ref ? isArray$1(ref) ? ref.concat(normalizeRef(extraProps)) : [ref, normalizeRef(extraProps)] : normalizeRef(extraProps) : ref,
		scopeId: vnode.scopeId,
		slotScopeIds: vnode.slotScopeIds,
		children,
		target: vnode.target,
		targetAnchor: vnode.targetAnchor,
		staticCount: vnode.staticCount,
		shapeFlag: vnode.shapeFlag,
		patchFlag: extraProps && vnode.type !== Fragment ? patchFlag === -1 ? 16 : patchFlag | 16 : patchFlag,
		dynamicProps: vnode.dynamicProps,
		dynamicChildren: vnode.dynamicChildren,
		appContext: vnode.appContext,
		dirs: vnode.dirs,
		transition,
		component: vnode.component,
		suspense: vnode.suspense,
		ssContent: vnode.ssContent && cloneVNode(vnode.ssContent),
		ssFallback: vnode.ssFallback && cloneVNode(vnode.ssFallback),
		el: vnode.el,
		anchor: vnode.anchor,
		ctx: vnode.ctx,
		ce: vnode.ce
	};
	if (transition && cloneTransition) setTransitionHooks(cloned, transition.clone(cloned));
	return cloned;
}
function createTextVNode(text = " ", flag = 0) {
	return createVNode(Text, null, text, flag);
}
function createStaticVNode(content, numberOfNodes) {
	const vnode = createVNode(Static, null, content);
	vnode.staticCount = numberOfNodes;
	return vnode;
}
function createCommentVNode(text = "", asBlock = false) {
	return asBlock ? (openBlock(), createBlock(Comment, null, text)) : createVNode(Comment, null, text);
}
function normalizeVNode(child) {
	if (child == null || typeof child === "boolean") return createVNode(Comment);
	else if (isArray$1(child)) return createVNode(Fragment, null, child.slice());
	else if (typeof child === "object") return cloneIfMounted(child);
	else return createVNode(Text, null, String(child));
}
function cloneIfMounted(child) {
	return child.el === null && child.patchFlag !== -1 || child.memo ? child : cloneVNode(child);
}
function normalizeChildren(vnode, children) {
	let type = 0;
	const { shapeFlag } = vnode;
	if (children == null) children = null;
	else if (isArray$1(children)) type = 16;
	else if (typeof children === "object") if (shapeFlag & 65) {
		const slot = children.default;
		if (slot) {
			slot._c && (slot._d = false);
			normalizeChildren(vnode, slot());
			slot._c && (slot._d = true);
		}
		return;
	} else {
		type = 32;
		const slotFlag = children._;
		if (!slotFlag && !isInternalObject(children)) children._ctx = currentRenderingInstance;
		else if (slotFlag === 3 && currentRenderingInstance) if (currentRenderingInstance.slots._ === 1) children._ = 1;
		else {
			children._ = 2;
			vnode.patchFlag |= 1024;
		}
	}
	else if (isFunction(children)) {
		children = {
			default: children,
			_ctx: currentRenderingInstance
		};
		type = 32;
	} else {
		children = String(children);
		if (shapeFlag & 64) {
			type = 16;
			children = [createTextVNode(children)];
		} else type = 8;
	}
	vnode.children = children;
	vnode.shapeFlag |= type;
}
function mergeProps(...args) {
	const ret = {};
	for (let i = 0; i < args.length; i++) {
		const toMerge = args[i];
		for (const key in toMerge) if (key === "class") {
			if (ret.class !== toMerge.class) ret.class = normalizeClass([ret.class, toMerge.class]);
		} else if (key === "style") ret.style = normalizeStyle([ret.style, toMerge.style]);
		else if (isOn(key)) {
			const existing = ret[key];
			const incoming = toMerge[key];
			if (incoming && existing !== incoming && !(isArray$1(existing) && existing.includes(incoming))) ret[key] = existing ? [].concat(existing, incoming) : incoming;
		} else if (key !== "") ret[key] = toMerge[key];
	}
	return ret;
}
function invokeVNodeHook(hook, instance, vnode, prevVNode = null) {
	callWithAsyncErrorHandling(hook, instance, 7, [vnode, prevVNode]);
}
var emptyAppContext = createAppContext();
var uid = 0;
function createComponentInstance(vnode, parent, suspense) {
	const type = vnode.type;
	const appContext = (parent ? parent.appContext : vnode.appContext) || emptyAppContext;
	const instance = {
		uid: uid++,
		vnode,
		type,
		parent,
		appContext,
		root: null,
		next: null,
		subTree: null,
		effect: null,
		update: null,
		scope: new EffectScope(true),
		render: null,
		proxy: null,
		exposed: null,
		exposeProxy: null,
		withProxy: null,
		provides: parent ? parent.provides : Object.create(appContext.provides),
		accessCache: null,
		renderCache: [],
		components: null,
		directives: null,
		propsOptions: normalizePropsOptions(type, appContext),
		emitsOptions: normalizeEmitsOptions(type, appContext),
		emit: null,
		emitted: null,
		propsDefaults: EMPTY_OBJ,
		inheritAttrs: type.inheritAttrs,
		ctx: EMPTY_OBJ,
		data: EMPTY_OBJ,
		props: EMPTY_OBJ,
		attrs: EMPTY_OBJ,
		slots: EMPTY_OBJ,
		refs: EMPTY_OBJ,
		setupState: EMPTY_OBJ,
		setupContext: null,
		attrsProxy: null,
		slotsProxy: null,
		suspense,
		suspenseId: suspense ? suspense.pendingId : 0,
		asyncDep: null,
		asyncResolved: false,
		isMounted: false,
		isUnmounted: false,
		isDeactivated: false,
		bc: null,
		c: null,
		bm: null,
		m: null,
		bu: null,
		u: null,
		um: null,
		bum: null,
		da: null,
		a: null,
		rtg: null,
		rtc: null,
		ec: null,
		sp: null
	};
	instance.ctx = { _: instance };
	instance.root = parent ? parent.root : instance;
	instance.emit = emit.bind(null, instance);
	if (vnode.ce) vnode.ce(instance);
	return instance;
}
var currentInstance = null;
var getCurrentInstance = () => currentInstance || currentRenderingInstance;
var internalSetCurrentInstance;
var setInSSRSetupState;
{
	const g = getGlobalThis();
	const registerGlobalSetter = (key, setter) => {
		let setters;
		if (!(setters = g[key])) setters = g[key] = [];
		setters.push(setter);
		return (v) => {
			if (setters.length > 1) setters.forEach((set) => set(v));
			else setters[0](v);
		};
	};
	internalSetCurrentInstance = registerGlobalSetter(`__VUE_INSTANCE_SETTERS__`, (v) => currentInstance = v);
	setInSSRSetupState = registerGlobalSetter(`__VUE_SSR_SETTERS__`, (v) => isInSSRComponentSetup = v);
}
var setCurrentInstance = (instance) => {
	const prev = currentInstance;
	internalSetCurrentInstance(instance);
	instance.scope.on();
	return () => {
		instance.scope.off();
		internalSetCurrentInstance(prev);
	};
};
var unsetCurrentInstance = () => {
	currentInstance && currentInstance.scope.off();
	internalSetCurrentInstance(null);
};
function isStatefulComponent(instance) {
	return instance.vnode.shapeFlag & 4;
}
var isInSSRComponentSetup = false;
function setupComponent(instance, isSSR = false) {
	isSSR && setInSSRSetupState(isSSR);
	const { props, children } = instance.vnode;
	const isStateful = isStatefulComponent(instance);
	initProps(instance, props, isStateful, isSSR);
	initSlots(instance, children);
	const setupResult = isStateful ? setupStatefulComponent(instance, isSSR) : void 0;
	isSSR && setInSSRSetupState(false);
	return setupResult;
}
function setupStatefulComponent(instance, isSSR) {
	const Component = instance.type;
	instance.accessCache = /* @__PURE__ */ Object.create(null);
	instance.proxy = new Proxy(instance.ctx, PublicInstanceProxyHandlers);
	const { setup } = Component;
	if (setup) {
		const setupContext = instance.setupContext = setup.length > 1 ? createSetupContext(instance) : null;
		const reset = setCurrentInstance(instance);
		pauseTracking();
		const setupResult = callWithErrorHandling(setup, instance, 0, [instance.props, setupContext]);
		resetTracking();
		reset();
		if (isPromise(setupResult)) {
			setupResult.then(unsetCurrentInstance, unsetCurrentInstance);
			if (isSSR) return setupResult.then((resolvedResult) => {
				handleSetupResult(instance, resolvedResult, isSSR);
			}).catch((e) => {
				handleError(e, instance, 0);
			});
			else instance.asyncDep = setupResult;
		} else handleSetupResult(instance, setupResult, isSSR);
	} else finishComponentSetup(instance, isSSR);
}
function handleSetupResult(instance, setupResult, isSSR) {
	if (isFunction(setupResult)) if (instance.type.__ssrInlineRender) instance.ssrRender = setupResult;
	else instance.render = setupResult;
	else if (isObject(setupResult)) instance.setupState = proxyRefs(setupResult);
	finishComponentSetup(instance, isSSR);
}
var compile$1;
var installWithProxy;
function registerRuntimeCompiler(_compile) {
	compile$1 = _compile;
	installWithProxy = (i) => {
		if (i.render._rc) i.withProxy = new Proxy(i.ctx, RuntimeCompiledPublicInstanceProxyHandlers);
	};
}
var isRuntimeOnly = () => !compile$1;
function finishComponentSetup(instance, isSSR, skipOptions) {
	const Component = instance.type;
	if (!instance.render) {
		if (!isSSR && compile$1 && !Component.render) {
			const template = Component.template || resolveMergedOptions(instance).template;
			if (template) {
				const { isCustomElement, compilerOptions } = instance.appContext.config;
				const { delimiters, compilerOptions: componentCompilerOptions } = Component;
				const finalCompilerOptions = extend(extend({
					isCustomElement,
					delimiters
				}, compilerOptions), componentCompilerOptions);
				Component.render = compile$1(template, finalCompilerOptions);
			}
		}
		instance.render = Component.render || NOOP;
		if (installWithProxy) installWithProxy(instance);
	}
	{
		const reset = setCurrentInstance(instance);
		pauseTracking();
		try {
			applyOptions(instance);
		} finally {
			resetTracking();
			reset();
		}
	}
}
var attrsProxyHandlers = { get(target, key) {
	track(target, "get", "");
	return target[key];
} };
function createSetupContext(instance) {
	const expose = (exposed) => {
		instance.exposed = exposed || {};
	};
	return {
		attrs: new Proxy(instance.attrs, attrsProxyHandlers),
		slots: instance.slots,
		emit: instance.emit,
		expose
	};
}
function getComponentPublicInstance(instance) {
	if (instance.exposed) return instance.exposeProxy || (instance.exposeProxy = new Proxy(proxyRefs(markRaw(instance.exposed)), {
		get(target, key) {
			if (key in target) return target[key];
			else if (key in publicPropertiesMap) return publicPropertiesMap[key](instance);
		},
		has(target, key) {
			return key in target || key in publicPropertiesMap;
		}
	}));
	else return instance.proxy;
}
function getComponentName(Component, includeInferred = true) {
	return isFunction(Component) ? Component.displayName || Component.name : Component.name || includeInferred && Component.__name;
}
function isClassComponent(value) {
	return isFunction(value) && "__vccOpts" in value;
}
var computed = (getterOrOptions, debugOptions) => {
	return computed$1(getterOrOptions, debugOptions, isInSSRComponentSetup);
};
function useModel(props, name, options = EMPTY_OBJ) {
	const i = getCurrentInstance();
	const camelizedName = camelize(name);
	const hyphenatedName = hyphenate(name);
	const res = customRef((track, trigger) => {
		let localValue;
		watchSyncEffect(() => {
			const propValue = props[name];
			if (hasChanged(localValue, propValue)) {
				localValue = propValue;
				trigger();
			}
		});
		return {
			get() {
				track();
				return options.get ? options.get(localValue) : localValue;
			},
			set(value) {
				const rawProps = i.vnode.props;
				if (!(rawProps && (name in rawProps || camelizedName in rawProps || hyphenatedName in rawProps) && (`onUpdate:${name}` in rawProps || `onUpdate:${camelizedName}` in rawProps || `onUpdate:${hyphenatedName}` in rawProps)) && hasChanged(value, localValue)) {
					localValue = value;
					trigger();
				}
				i.emit(`update:${name}`, options.set ? options.set(value) : value);
			}
		};
	});
	const modifierKey = name === "modelValue" ? "modelModifiers" : `${name}Modifiers`;
	res[Symbol.iterator] = () => {
		let i2 = 0;
		return { next() {
			if (i2 < 2) return {
				value: i2++ ? props[modifierKey] || {} : res,
				done: false
			};
			else return { done: true };
		} };
	};
	return res;
}
function h(type, propsOrChildren, children) {
	const l = arguments.length;
	if (l === 2) if (isObject(propsOrChildren) && !isArray$1(propsOrChildren)) {
		if (isVNode(propsOrChildren)) return createVNode(type, null, [propsOrChildren]);
		return createVNode(type, propsOrChildren);
	} else return createVNode(type, null, propsOrChildren);
	else {
		if (l > 3) children = Array.prototype.slice.call(arguments, 2);
		else if (l === 3 && isVNode(children)) children = [children];
		return createVNode(type, propsOrChildren, children);
	}
}
function initCustomFormatter() {
	return;
	function isKeyOfType(Comp, key, type) {
		const opts = Comp[type];
		if (isArray$1(opts) && opts.includes(key) || isObject(opts) && key in opts) return true;
		if (Comp.extends && isKeyOfType(Comp.extends, key, type)) return true;
		if (Comp.mixins && Comp.mixins.some((m) => isKeyOfType(m, key, type))) return true;
	}
}
function withMemo(memo, render, cache, index) {
	const cached = cache[index];
	if (cached && isMemoSame(cached, memo)) return cached;
	const ret = render();
	ret.memo = memo.slice();
	ret.memoIndex = index;
	return cache[index] = ret;
}
function isMemoSame(cached, memo) {
	const prev = cached.memo;
	if (prev.length != memo.length) return false;
	for (let i = 0; i < prev.length; i++) if (hasChanged(prev[i], memo[i])) return false;
	if (isBlockTreeEnabled > 0 && currentBlock) currentBlock.push(cached);
	return true;
}
var version = "3.4.29";
var warn = NOOP;
var ErrorTypeStrings = ErrorTypeStrings$1;
var devtools = devtools$1;
var setDevtoolsHook = setDevtoolsHook$1;
var ssrUtils = {
	createComponentInstance,
	setupComponent,
	renderComponentRoot,
	setCurrentRenderingInstance,
	isVNode,
	normalizeVNode,
	getComponentPublicInstance
};
//#endregion
//#region node_modules/@vue/runtime-dom/dist/runtime-dom.esm-bundler.js
/**
* @vue/runtime-dom v3.4.29
* (c) 2018-present Yuxi (Evan) You and Vue contributors
* @license MIT
**/
var svgNS = "http://www.w3.org/2000/svg";
var mathmlNS = "http://www.w3.org/1998/Math/MathML";
var doc = typeof document !== "undefined" ? document : null;
var templateContainer = doc && /* @__PURE__ */ doc.createElement("template");
var nodeOps = {
	insert: (child, parent, anchor) => {
		parent.insertBefore(child, anchor || null);
	},
	remove: (child) => {
		const parent = child.parentNode;
		if (parent) parent.removeChild(child);
	},
	createElement: (tag, namespace, is, props) => {
		const el = namespace === "svg" ? doc.createElementNS(svgNS, tag) : namespace === "mathml" ? doc.createElementNS(mathmlNS, tag) : is ? doc.createElement(tag, { is }) : doc.createElement(tag);
		if (tag === "select" && props && props.multiple != null) el.setAttribute("multiple", props.multiple);
		return el;
	},
	createText: (text) => doc.createTextNode(text),
	createComment: (text) => doc.createComment(text),
	setText: (node, text) => {
		node.nodeValue = text;
	},
	setElementText: (el, text) => {
		el.textContent = text;
	},
	parentNode: (node) => node.parentNode,
	nextSibling: (node) => node.nextSibling,
	querySelector: (selector) => doc.querySelector(selector),
	setScopeId(el, id) {
		el.setAttribute(id, "");
	},
	insertStaticContent(content, parent, anchor, namespace, start, end) {
		const before = anchor ? anchor.previousSibling : parent.lastChild;
		if (start && (start === end || start.nextSibling)) while (true) {
			parent.insertBefore(start.cloneNode(true), anchor);
			if (start === end || !(start = start.nextSibling)) break;
		}
		else {
			templateContainer.innerHTML = namespace === "svg" ? `<svg>${content}</svg>` : namespace === "mathml" ? `<math>${content}</math>` : content;
			const template = templateContainer.content;
			if (namespace === "svg" || namespace === "mathml") {
				const wrapper = template.firstChild;
				while (wrapper.firstChild) template.appendChild(wrapper.firstChild);
				template.removeChild(wrapper);
			}
			parent.insertBefore(template, anchor);
		}
		return [before ? before.nextSibling : parent.firstChild, anchor ? anchor.previousSibling : parent.lastChild];
	}
};
var TRANSITION = "transition";
var ANIMATION = "animation";
var vtcKey = Symbol("_vtc");
var Transition = (props, { slots }) => h(BaseTransition, resolveTransitionProps(props), slots);
Transition.displayName = "Transition";
var DOMTransitionPropsValidators = {
	name: String,
	type: String,
	css: {
		type: Boolean,
		default: true
	},
	duration: [
		String,
		Number,
		Object
	],
	enterFromClass: String,
	enterActiveClass: String,
	enterToClass: String,
	appearFromClass: String,
	appearActiveClass: String,
	appearToClass: String,
	leaveFromClass: String,
	leaveActiveClass: String,
	leaveToClass: String
};
var TransitionPropsValidators = Transition.props = /* @__PURE__ */ extend({}, BaseTransitionPropsValidators, DOMTransitionPropsValidators);
var callHook = (hook, args = []) => {
	if (isArray$1(hook)) hook.forEach((h2) => h2(...args));
	else if (hook) hook(...args);
};
var hasExplicitCallback = (hook) => {
	return hook ? isArray$1(hook) ? hook.some((h2) => h2.length > 1) : hook.length > 1 : false;
};
function resolveTransitionProps(rawProps) {
	const baseProps = {};
	for (const key in rawProps) if (!(key in DOMTransitionPropsValidators)) baseProps[key] = rawProps[key];
	if (rawProps.css === false) return baseProps;
	const { name = "v", type, duration, enterFromClass = `${name}-enter-from`, enterActiveClass = `${name}-enter-active`, enterToClass = `${name}-enter-to`, appearFromClass = enterFromClass, appearActiveClass = enterActiveClass, appearToClass = enterToClass, leaveFromClass = `${name}-leave-from`, leaveActiveClass = `${name}-leave-active`, leaveToClass = `${name}-leave-to` } = rawProps;
	const durations = normalizeDuration(duration);
	const enterDuration = durations && durations[0];
	const leaveDuration = durations && durations[1];
	const { onBeforeEnter, onEnter, onEnterCancelled, onLeave, onLeaveCancelled, onBeforeAppear = onBeforeEnter, onAppear = onEnter, onAppearCancelled = onEnterCancelled } = baseProps;
	const finishEnter = (el, isAppear, done) => {
		removeTransitionClass(el, isAppear ? appearToClass : enterToClass);
		removeTransitionClass(el, isAppear ? appearActiveClass : enterActiveClass);
		done && done();
	};
	const finishLeave = (el, done) => {
		el._isLeaving = false;
		removeTransitionClass(el, leaveFromClass);
		removeTransitionClass(el, leaveToClass);
		removeTransitionClass(el, leaveActiveClass);
		done && done();
	};
	const makeEnterHook = (isAppear) => {
		return (el, done) => {
			const hook = isAppear ? onAppear : onEnter;
			const resolve = () => finishEnter(el, isAppear, done);
			callHook(hook, [el, resolve]);
			nextFrame(() => {
				removeTransitionClass(el, isAppear ? appearFromClass : enterFromClass);
				addTransitionClass(el, isAppear ? appearToClass : enterToClass);
				if (!hasExplicitCallback(hook)) whenTransitionEnds(el, type, enterDuration, resolve);
			});
		};
	};
	return extend(baseProps, {
		onBeforeEnter(el) {
			callHook(onBeforeEnter, [el]);
			addTransitionClass(el, enterFromClass);
			addTransitionClass(el, enterActiveClass);
		},
		onBeforeAppear(el) {
			callHook(onBeforeAppear, [el]);
			addTransitionClass(el, appearFromClass);
			addTransitionClass(el, appearActiveClass);
		},
		onEnter: makeEnterHook(false),
		onAppear: makeEnterHook(true),
		onLeave(el, done) {
			el._isLeaving = true;
			const resolve = () => finishLeave(el, done);
			addTransitionClass(el, leaveFromClass);
			addTransitionClass(el, leaveActiveClass);
			forceReflow();
			nextFrame(() => {
				if (!el._isLeaving) return;
				removeTransitionClass(el, leaveFromClass);
				addTransitionClass(el, leaveToClass);
				if (!hasExplicitCallback(onLeave)) whenTransitionEnds(el, type, leaveDuration, resolve);
			});
			callHook(onLeave, [el, resolve]);
		},
		onEnterCancelled(el) {
			finishEnter(el, false);
			callHook(onEnterCancelled, [el]);
		},
		onAppearCancelled(el) {
			finishEnter(el, true);
			callHook(onAppearCancelled, [el]);
		},
		onLeaveCancelled(el) {
			finishLeave(el);
			callHook(onLeaveCancelled, [el]);
		}
	});
}
function normalizeDuration(duration) {
	if (duration == null) return null;
	else if (isObject(duration)) return [NumberOf(duration.enter), NumberOf(duration.leave)];
	else {
		const n = NumberOf(duration);
		return [n, n];
	}
}
function NumberOf(val) {
	return toNumber(val);
}
function addTransitionClass(el, cls) {
	cls.split(/\s+/).forEach((c) => c && el.classList.add(c));
	(el[vtcKey] || (el[vtcKey] = /* @__PURE__ */ new Set())).add(cls);
}
function removeTransitionClass(el, cls) {
	cls.split(/\s+/).forEach((c) => c && el.classList.remove(c));
	const _vtc = el[vtcKey];
	if (_vtc) {
		_vtc.delete(cls);
		if (!_vtc.size) el[vtcKey] = void 0;
	}
}
function nextFrame(cb) {
	requestAnimationFrame(() => {
		requestAnimationFrame(cb);
	});
}
var endId = 0;
function whenTransitionEnds(el, expectedType, explicitTimeout, resolve) {
	const id = el._endId = ++endId;
	const resolveIfNotStale = () => {
		if (id === el._endId) resolve();
	};
	if (explicitTimeout) return setTimeout(resolveIfNotStale, explicitTimeout);
	const { type, timeout, propCount } = getTransitionInfo(el, expectedType);
	if (!type) return resolve();
	const endEvent = type + "end";
	let ended = 0;
	const end = () => {
		el.removeEventListener(endEvent, onEnd);
		resolveIfNotStale();
	};
	const onEnd = (e) => {
		if (e.target === el && ++ended >= propCount) end();
	};
	setTimeout(() => {
		if (ended < propCount) end();
	}, timeout + 1);
	el.addEventListener(endEvent, onEnd);
}
function getTransitionInfo(el, expectedType) {
	const styles = window.getComputedStyle(el);
	const getStyleProperties = (key) => (styles[key] || "").split(", ");
	const transitionDelays = getStyleProperties(`${TRANSITION}Delay`);
	const transitionDurations = getStyleProperties(`${TRANSITION}Duration`);
	const transitionTimeout = getTimeout(transitionDelays, transitionDurations);
	const animationDelays = getStyleProperties(`${ANIMATION}Delay`);
	const animationDurations = getStyleProperties(`${ANIMATION}Duration`);
	const animationTimeout = getTimeout(animationDelays, animationDurations);
	let type = null;
	let timeout = 0;
	let propCount = 0;
	if (expectedType === TRANSITION) {
		if (transitionTimeout > 0) {
			type = TRANSITION;
			timeout = transitionTimeout;
			propCount = transitionDurations.length;
		}
	} else if (expectedType === ANIMATION) {
		if (animationTimeout > 0) {
			type = ANIMATION;
			timeout = animationTimeout;
			propCount = animationDurations.length;
		}
	} else {
		timeout = Math.max(transitionTimeout, animationTimeout);
		type = timeout > 0 ? transitionTimeout > animationTimeout ? TRANSITION : ANIMATION : null;
		propCount = type ? type === TRANSITION ? transitionDurations.length : animationDurations.length : 0;
	}
	const hasTransform = type === TRANSITION && /\b(transform|all)(,|$)/.test(getStyleProperties(`${TRANSITION}Property`).toString());
	return {
		type,
		timeout,
		propCount,
		hasTransform
	};
}
function getTimeout(delays, durations) {
	while (delays.length < durations.length) delays = delays.concat(delays);
	return Math.max(...durations.map((d, i) => toMs(d) + toMs(delays[i])));
}
function toMs(s) {
	if (s === "auto") return 0;
	return Number(s.slice(0, -1).replace(",", ".")) * 1e3;
}
function forceReflow() {
	return document.body.offsetHeight;
}
function patchClass(el, value, isSVG) {
	const transitionClasses = el[vtcKey];
	if (transitionClasses) value = (value ? [value, ...transitionClasses] : [...transitionClasses]).join(" ");
	if (value == null) el.removeAttribute("class");
	else if (isSVG) el.setAttribute("class", value);
	else el.className = value;
}
var vShowOriginalDisplay = Symbol("_vod");
var vShowHidden = Symbol("_vsh");
var vShow = {
	beforeMount(el, { value }, { transition }) {
		el[vShowOriginalDisplay] = el.style.display === "none" ? "" : el.style.display;
		if (transition && value) transition.beforeEnter(el);
		else setDisplay(el, value);
	},
	mounted(el, { value }, { transition }) {
		if (transition && value) transition.enter(el);
	},
	updated(el, { value, oldValue }, { transition }) {
		if (!value === !oldValue) return;
		if (transition) if (value) {
			transition.beforeEnter(el);
			setDisplay(el, true);
			transition.enter(el);
		} else transition.leave(el, () => {
			setDisplay(el, false);
		});
		else setDisplay(el, value);
	},
	beforeUnmount(el, { value }) {
		setDisplay(el, value);
	}
};
function setDisplay(el, value) {
	el.style.display = value ? el[vShowOriginalDisplay] : "none";
	el[vShowHidden] = !value;
}
function initVShowForSSR() {
	vShow.getSSRProps = ({ value }) => {
		if (!value) return { style: { display: "none" } };
	};
}
var CSS_VAR_TEXT = Symbol("");
function useCssVars(getter) {
	const instance = getCurrentInstance();
	if (!instance) return;
	const updateTeleports = instance.ut = (vars = getter(instance.proxy)) => {
		Array.from(document.querySelectorAll(`[data-v-owner="${instance.uid}"]`)).forEach((node) => setVarsOnNode(node, vars));
	};
	const setVars = () => {
		const vars = getter(instance.proxy);
		setVarsOnVNode(instance.subTree, vars);
		updateTeleports(vars);
	};
	onMounted(() => {
		watchPostEffect(setVars);
		const ob = new MutationObserver(setVars);
		ob.observe(instance.subTree.el.parentNode, { childList: true });
		onUnmounted(() => ob.disconnect());
	});
}
function setVarsOnVNode(vnode, vars) {
	if (vnode.shapeFlag & 128) {
		const suspense = vnode.suspense;
		vnode = suspense.activeBranch;
		if (suspense.pendingBranch && !suspense.isHydrating) suspense.effects.push(() => {
			setVarsOnVNode(suspense.activeBranch, vars);
		});
	}
	while (vnode.component) vnode = vnode.component.subTree;
	if (vnode.shapeFlag & 1 && vnode.el) setVarsOnNode(vnode.el, vars);
	else if (vnode.type === Fragment) vnode.children.forEach((c) => setVarsOnVNode(c, vars));
	else if (vnode.type === Static) {
		let { el, anchor } = vnode;
		while (el) {
			setVarsOnNode(el, vars);
			if (el === anchor) break;
			el = el.nextSibling;
		}
	}
}
function setVarsOnNode(el, vars) {
	if (el.nodeType === 1) {
		const style = el.style;
		let cssText = "";
		for (const key in vars) {
			style.setProperty(`--${key}`, vars[key]);
			cssText += `--${key}: ${vars[key]};`;
		}
		style[CSS_VAR_TEXT] = cssText;
	}
}
var displayRE = /(^|;)\s*display\s*:/;
function patchStyle(el, prev, next) {
	const style = el.style;
	const isCssString = isString(next);
	let hasControlledDisplay = false;
	if (next && !isCssString) {
		if (prev) if (!isString(prev)) {
			for (const key in prev) if (next[key] == null) setStyle(style, key, "");
		} else for (const prevStyle of prev.split(";")) {
			const key = prevStyle.slice(0, prevStyle.indexOf(":")).trim();
			if (next[key] == null) setStyle(style, key, "");
		}
		for (const key in next) {
			if (key === "display") hasControlledDisplay = true;
			setStyle(style, key, next[key]);
		}
	} else if (isCssString) {
		if (prev !== next) {
			const cssVarText = style[CSS_VAR_TEXT];
			if (cssVarText) next += ";" + cssVarText;
			style.cssText = next;
			hasControlledDisplay = displayRE.test(next);
		}
	} else if (prev) el.removeAttribute("style");
	if (vShowOriginalDisplay in el) {
		el[vShowOriginalDisplay] = hasControlledDisplay ? style.display : "";
		if (el[vShowHidden]) style.display = "none";
	}
}
var importantRE = /\s*!important$/;
function setStyle(style, name, val) {
	if (isArray$1(val)) val.forEach((v) => setStyle(style, name, v));
	else {
		if (val == null) val = "";
		if (name.startsWith("--")) style.setProperty(name, val);
		else {
			const prefixed = autoPrefix(style, name);
			if (importantRE.test(val)) style.setProperty(hyphenate(prefixed), val.replace(importantRE, ""), "important");
			else style[prefixed] = val;
		}
	}
}
var prefixes = [
	"Webkit",
	"Moz",
	"ms"
];
var prefixCache = {};
function autoPrefix(style, rawName) {
	const cached = prefixCache[rawName];
	if (cached) return cached;
	let name = camelize(rawName);
	if (name !== "filter" && name in style) return prefixCache[rawName] = name;
	name = capitalize(name);
	for (let i = 0; i < prefixes.length; i++) {
		const prefixed = prefixes[i] + name;
		if (prefixed in style) return prefixCache[rawName] = prefixed;
	}
	return rawName;
}
var xlinkNS = "http://www.w3.org/1999/xlink";
function patchAttr(el, key, value, isSVG, instance, isBoolean = isSpecialBooleanAttr(key)) {
	if (isSVG && key.startsWith("xlink:")) if (value == null) el.removeAttributeNS(xlinkNS, key.slice(6, key.length));
	else el.setAttributeNS(xlinkNS, key, value);
	else if (value == null || isBoolean && !includeBooleanAttr(value)) el.removeAttribute(key);
	else el.setAttribute(key, isBoolean ? "" : String(value));
}
function patchDOMProp(el, key, value, prevChildren, parentComponent, parentSuspense, unmountChildren) {
	if (key === "innerHTML" || key === "textContent") {
		if (prevChildren) unmountChildren(prevChildren, parentComponent, parentSuspense);
		el[key] = value == null ? "" : value;
		return;
	}
	const tag = el.tagName;
	if (key === "value" && tag !== "PROGRESS" && !tag.includes("-")) {
		const oldValue = tag === "OPTION" ? el.getAttribute("value") || "" : el.value;
		const newValue = value == null ? "" : String(value);
		if (oldValue !== newValue || !("_value" in el)) el.value = newValue;
		if (value == null) el.removeAttribute(key);
		el._value = value;
		return;
	}
	let needRemove = false;
	if (value === "" || value == null) {
		const type = typeof el[key];
		if (type === "boolean") value = includeBooleanAttr(value);
		else if (value == null && type === "string") {
			value = "";
			needRemove = true;
		} else if (type === "number") {
			value = 0;
			needRemove = true;
		}
	}
	try {
		el[key] = value;
	} catch (e) {}
	needRemove && el.removeAttribute(key);
}
function addEventListener(el, event, handler, options) {
	el.addEventListener(event, handler, options);
}
function removeEventListener(el, event, handler, options) {
	el.removeEventListener(event, handler, options);
}
var veiKey = Symbol("_vei");
function patchEvent(el, rawName, prevValue, nextValue, instance = null) {
	const invokers = el[veiKey] || (el[veiKey] = {});
	const existingInvoker = invokers[rawName];
	if (nextValue && existingInvoker) existingInvoker.value = nextValue;
	else {
		const [name, options] = parseName(rawName);
		if (nextValue) addEventListener(el, name, invokers[rawName] = createInvoker(nextValue, instance), options);
		else if (existingInvoker) {
			removeEventListener(el, name, existingInvoker, options);
			invokers[rawName] = void 0;
		}
	}
}
var optionsModifierRE = /(?:Once|Passive|Capture)$/;
function parseName(name) {
	let options;
	if (optionsModifierRE.test(name)) {
		options = {};
		let m;
		while (m = name.match(optionsModifierRE)) {
			name = name.slice(0, name.length - m[0].length);
			options[m[0].toLowerCase()] = true;
		}
	}
	return [name[2] === ":" ? name.slice(3) : hyphenate(name.slice(2)), options];
}
var cachedNow = 0;
var p = /* @__PURE__ */ Promise.resolve();
var getNow = () => cachedNow || (p.then(() => cachedNow = 0), cachedNow = Date.now());
function createInvoker(initialValue, instance) {
	const invoker = (e) => {
		if (!e._vts) e._vts = Date.now();
		else if (e._vts <= invoker.attached) return;
		callWithAsyncErrorHandling(patchStopImmediatePropagation(e, invoker.value), instance, 5, [e]);
	};
	invoker.value = initialValue;
	invoker.attached = getNow();
	return invoker;
}
function patchStopImmediatePropagation(e, value) {
	if (isArray$1(value)) {
		const originalStop = e.stopImmediatePropagation;
		e.stopImmediatePropagation = () => {
			originalStop.call(e);
			e._stopped = true;
		};
		return value.map((fn) => (e2) => !e2._stopped && fn && fn(e2));
	} else return value;
}
var isNativeOn = (key) => key.charCodeAt(0) === 111 && key.charCodeAt(1) === 110 && key.charCodeAt(2) > 96 && key.charCodeAt(2) < 123;
var patchProp = (el, key, prevValue, nextValue, namespace, prevChildren, parentComponent, parentSuspense, unmountChildren) => {
	const isSVG = namespace === "svg";
	if (key === "class") patchClass(el, nextValue, isSVG);
	else if (key === "style") patchStyle(el, prevValue, nextValue);
	else if (isOn(key)) {
		if (!isModelListener(key)) patchEvent(el, key, prevValue, nextValue, parentComponent);
	} else if (key[0] === "." ? (key = key.slice(1), true) : key[0] === "^" ? (key = key.slice(1), false) : shouldSetAsProp(el, key, nextValue, isSVG)) {
		patchDOMProp(el, key, nextValue, prevChildren, parentComponent, parentSuspense, unmountChildren);
		if (key === "value" || key === "checked" || key === "selected") patchAttr(el, key, nextValue, isSVG, parentComponent, key !== "value");
	} else {
		if (key === "true-value") el._trueValue = nextValue;
		else if (key === "false-value") el._falseValue = nextValue;
		patchAttr(el, key, nextValue, isSVG);
	}
};
function shouldSetAsProp(el, key, value, isSVG) {
	if (isSVG) {
		if (key === "innerHTML" || key === "textContent") return true;
		if (key in el && isNativeOn(key) && isFunction(value)) return true;
		return false;
	}
	if (key === "spellcheck" || key === "draggable" || key === "translate") return false;
	if (key === "form") return false;
	if (key === "list" && el.tagName === "INPUT") return false;
	if (key === "type" && el.tagName === "TEXTAREA") return false;
	if (key === "width" || key === "height") {
		const tag = el.tagName;
		if (tag === "IMG" || tag === "VIDEO" || tag === "CANVAS" || tag === "SOURCE") return false;
	}
	if (isNativeOn(key) && isString(value)) return false;
	return key in el;
}
/*! #__NO_SIDE_EFFECTS__ */
/* @__NO_SIDE_EFFECTS__ */
function defineCustomElement(options, extraOptions, hydrate2) {
	const Comp = /* @__PURE__ */ defineComponent(options, extraOptions);
	class VueCustomElement extends VueElement {
		constructor(initialProps) {
			super(Comp, initialProps, hydrate2);
		}
	}
	VueCustomElement.def = Comp;
	return VueCustomElement;
}
/*! #__NO_SIDE_EFFECTS__ */
var defineSSRCustomElement = /* @__NO_SIDE_EFFECTS__ */ (options, extraOptions) => {
	return /* @__PURE__ */ defineCustomElement(options, extraOptions, hydrate);
};
var BaseClass = typeof HTMLElement !== "undefined" ? HTMLElement : class {};
var VueElement = class VueElement extends BaseClass {
	constructor(_def, _props = {}, hydrate2) {
		super();
		this._def = _def;
		this._props = _props;
		/**
		* @internal
		*/
		this._instance = null;
		this._connected = false;
		this._resolved = false;
		this._numberProps = null;
		this._ob = null;
		if (this.shadowRoot && hydrate2) hydrate2(this._createVNode(), this.shadowRoot);
		else {
			this.attachShadow({ mode: "open" });
			if (!this._def.__asyncLoader) this._resolveProps(this._def);
		}
	}
	connectedCallback() {
		this._connected = true;
		if (!this._instance) if (this._resolved) this._update();
		else this._resolveDef();
	}
	disconnectedCallback() {
		this._connected = false;
		nextTick(() => {
			if (!this._connected) {
				if (this._ob) {
					this._ob.disconnect();
					this._ob = null;
				}
				render(null, this.shadowRoot);
				this._instance = null;
			}
		});
	}
	/**
	* resolve inner component definition (handle possible async component)
	*/
	_resolveDef() {
		this._resolved = true;
		for (let i = 0; i < this.attributes.length; i++) this._setAttr(this.attributes[i].name);
		this._ob = new MutationObserver((mutations) => {
			for (const m of mutations) this._setAttr(m.attributeName);
		});
		this._ob.observe(this, { attributes: true });
		const resolve = (def, isAsync = false) => {
			const { props, styles } = def;
			let numberProps;
			if (props && !isArray$1(props)) for (const key in props) {
				const opt = props[key];
				if (opt === Number || opt && opt.type === Number) {
					if (key in this._props) this._props[key] = toNumber(this._props[key]);
					(numberProps || (numberProps = /* @__PURE__ */ Object.create(null)))[camelize(key)] = true;
				}
			}
			this._numberProps = numberProps;
			if (isAsync) this._resolveProps(def);
			this._applyStyles(styles);
			this._update();
		};
		const asyncDef = this._def.__asyncLoader;
		if (asyncDef) asyncDef().then((def) => resolve(def, true));
		else resolve(this._def);
	}
	_resolveProps(def) {
		const { props } = def;
		const declaredPropKeys = isArray$1(props) ? props : Object.keys(props || {});
		for (const key of Object.keys(this)) if (key[0] !== "_" && declaredPropKeys.includes(key)) this._setProp(key, this[key], true, false);
		for (const key of declaredPropKeys.map(camelize)) Object.defineProperty(this, key, {
			get() {
				return this._getProp(key);
			},
			set(val) {
				this._setProp(key, val);
			}
		});
	}
	_setAttr(key) {
		let value = this.hasAttribute(key) ? this.getAttribute(key) : void 0;
		const camelKey = camelize(key);
		if (this._numberProps && this._numberProps[camelKey]) value = toNumber(value);
		this._setProp(camelKey, value, false);
	}
	/**
	* @internal
	*/
	_getProp(key) {
		return this._props[key];
	}
	/**
	* @internal
	*/
	_setProp(key, val, shouldReflect = true, shouldUpdate = true) {
		if (val !== this._props[key]) {
			this._props[key] = val;
			if (shouldUpdate && this._instance) this._update();
			if (shouldReflect) {
				if (val === true) this.setAttribute(hyphenate(key), "");
				else if (typeof val === "string" || typeof val === "number") this.setAttribute(hyphenate(key), val + "");
				else if (!val) this.removeAttribute(hyphenate(key));
			}
		}
	}
	_update() {
		render(this._createVNode(), this.shadowRoot);
	}
	_createVNode() {
		const vnode = createVNode(this._def, extend({}, this._props));
		if (!this._instance) vnode.ce = (instance) => {
			this._instance = instance;
			instance.isCE = true;
			const dispatch = (event, args) => {
				this.dispatchEvent(new CustomEvent(event, { detail: args }));
			};
			instance.emit = (event, ...args) => {
				dispatch(event, args);
				if (hyphenate(event) !== event) dispatch(hyphenate(event), args);
			};
			let parent = this;
			while (parent = parent && (parent.parentNode || parent.host)) if (parent instanceof VueElement) {
				instance.parent = parent._instance;
				instance.provides = parent._instance.provides;
				break;
			}
		};
		return vnode;
	}
	_applyStyles(styles) {
		if (styles) styles.forEach((css) => {
			const s = document.createElement("style");
			s.textContent = css;
			this.shadowRoot.appendChild(s);
		});
	}
};
function useCssModule(name = "$style") {
	{
		const instance = getCurrentInstance();
		if (!instance) return EMPTY_OBJ;
		const modules = instance.type.__cssModules;
		if (!modules) return EMPTY_OBJ;
		const mod = modules[name];
		if (!mod) return EMPTY_OBJ;
		return mod;
	}
}
var positionMap = /* @__PURE__ */ new WeakMap();
var newPositionMap = /* @__PURE__ */ new WeakMap();
var moveCbKey = Symbol("_moveCb");
var enterCbKey = Symbol("_enterCb");
var TransitionGroupImpl = {
	name: "TransitionGroup",
	props: /* @__PURE__ */ extend({}, TransitionPropsValidators, {
		tag: String,
		moveClass: String
	}),
	setup(props, { slots }) {
		const instance = getCurrentInstance();
		const state = useTransitionState();
		let prevChildren;
		let children;
		onUpdated(() => {
			if (!prevChildren.length) return;
			const moveClass = props.moveClass || `${props.name || "v"}-move`;
			if (!hasCSSTransform(prevChildren[0].el, instance.vnode.el, moveClass)) return;
			prevChildren.forEach(callPendingCbs);
			prevChildren.forEach(recordPosition);
			const movedChildren = prevChildren.filter(applyTranslation);
			forceReflow();
			movedChildren.forEach((c) => {
				const el = c.el;
				const style = el.style;
				addTransitionClass(el, moveClass);
				style.transform = style.webkitTransform = style.transitionDuration = "";
				const cb = el[moveCbKey] = (e) => {
					if (e && e.target !== el) return;
					if (!e || /transform$/.test(e.propertyName)) {
						el.removeEventListener("transitionend", cb);
						el[moveCbKey] = null;
						removeTransitionClass(el, moveClass);
					}
				};
				el.addEventListener("transitionend", cb);
			});
		});
		return () => {
			const rawProps = toRaw(props);
			const cssTransitionProps = resolveTransitionProps(rawProps);
			let tag = rawProps.tag || Fragment;
			prevChildren = [];
			if (children) for (let i = 0; i < children.length; i++) {
				const child = children[i];
				if (child.el && child.el instanceof Element) {
					prevChildren.push(child);
					setTransitionHooks(child, resolveTransitionHooks(child, cssTransitionProps, state, instance));
					positionMap.set(child, child.el.getBoundingClientRect());
				}
			}
			children = slots.default ? getTransitionRawChildren(slots.default()) : [];
			for (let i = 0; i < children.length; i++) {
				const child = children[i];
				if (child.key != null) setTransitionHooks(child, resolveTransitionHooks(child, cssTransitionProps, state, instance));
			}
			return createVNode(tag, null, children);
		};
	}
};
TransitionGroupImpl.props;
var TransitionGroup = TransitionGroupImpl;
function callPendingCbs(c) {
	const el = c.el;
	if (el[moveCbKey]) el[moveCbKey]();
	if (el[enterCbKey]) el[enterCbKey]();
}
function recordPosition(c) {
	newPositionMap.set(c, c.el.getBoundingClientRect());
}
function applyTranslation(c) {
	const oldPos = positionMap.get(c);
	const newPos = newPositionMap.get(c);
	const dx = oldPos.left - newPos.left;
	const dy = oldPos.top - newPos.top;
	if (dx || dy) {
		const s = c.el.style;
		s.transform = s.webkitTransform = `translate(${dx}px,${dy}px)`;
		s.transitionDuration = "0s";
		return c;
	}
}
function hasCSSTransform(el, root, moveClass) {
	const clone = el.cloneNode();
	const _vtc = el[vtcKey];
	if (_vtc) _vtc.forEach((cls) => {
		cls.split(/\s+/).forEach((c) => c && clone.classList.remove(c));
	});
	moveClass.split(/\s+/).forEach((c) => c && clone.classList.add(c));
	clone.style.display = "none";
	const container = root.nodeType === 1 ? root : root.parentNode;
	container.appendChild(clone);
	const { hasTransform } = getTransitionInfo(clone);
	container.removeChild(clone);
	return hasTransform;
}
var getModelAssigner = (vnode) => {
	const fn = vnode.props["onUpdate:modelValue"] || false;
	return isArray$1(fn) ? (value) => invokeArrayFns(fn, value) : fn;
};
function onCompositionStart(e) {
	e.target.composing = true;
}
function onCompositionEnd(e) {
	const target = e.target;
	if (target.composing) {
		target.composing = false;
		target.dispatchEvent(new Event("input"));
	}
}
var assignKey = Symbol("_assign");
var vModelText = {
	created(el, { modifiers: { lazy, trim, number } }, vnode) {
		el[assignKey] = getModelAssigner(vnode);
		const castToNumber = number || vnode.props && vnode.props.type === "number";
		addEventListener(el, lazy ? "change" : "input", (e) => {
			if (e.target.composing) return;
			let domValue = el.value;
			if (trim) domValue = domValue.trim();
			if (castToNumber) domValue = looseToNumber(domValue);
			el[assignKey](domValue);
		});
		if (trim) addEventListener(el, "change", () => {
			el.value = el.value.trim();
		});
		if (!lazy) {
			addEventListener(el, "compositionstart", onCompositionStart);
			addEventListener(el, "compositionend", onCompositionEnd);
			addEventListener(el, "change", onCompositionEnd);
		}
	},
	mounted(el, { value }) {
		el.value = value == null ? "" : value;
	},
	beforeUpdate(el, { value, oldValue, modifiers: { lazy, trim, number } }, vnode) {
		el[assignKey] = getModelAssigner(vnode);
		if (el.composing) return;
		const elValue = (number || el.type === "number") && !/^0\d/.test(el.value) ? looseToNumber(el.value) : el.value;
		const newValue = value == null ? "" : value;
		if (elValue === newValue) return;
		if (document.activeElement === el && el.type !== "range") {
			if (lazy && value === oldValue) return;
			if (trim && el.value.trim() === newValue) return;
		}
		el.value = newValue;
	}
};
var vModelCheckbox = {
	deep: true,
	created(el, _, vnode) {
		el[assignKey] = getModelAssigner(vnode);
		addEventListener(el, "change", () => {
			const modelValue = el._modelValue;
			const elementValue = getValue(el);
			const checked = el.checked;
			const assign = el[assignKey];
			if (isArray$1(modelValue)) {
				const index = looseIndexOf(modelValue, elementValue);
				const found = index !== -1;
				if (checked && !found) assign(modelValue.concat(elementValue));
				else if (!checked && found) {
					const filtered = [...modelValue];
					filtered.splice(index, 1);
					assign(filtered);
				}
			} else if (isSet(modelValue)) {
				const cloned = new Set(modelValue);
				if (checked) cloned.add(elementValue);
				else cloned.delete(elementValue);
				assign(cloned);
			} else assign(getCheckboxValue(el, checked));
		});
	},
	mounted: setChecked,
	beforeUpdate(el, binding, vnode) {
		el[assignKey] = getModelAssigner(vnode);
		setChecked(el, binding, vnode);
	}
};
function setChecked(el, { value, oldValue }, vnode) {
	el._modelValue = value;
	if (isArray$1(value)) el.checked = looseIndexOf(value, vnode.props.value) > -1;
	else if (isSet(value)) el.checked = value.has(vnode.props.value);
	else if (value !== oldValue) el.checked = looseEqual(value, getCheckboxValue(el, true));
}
var vModelRadio = {
	created(el, { value }, vnode) {
		el.checked = looseEqual(value, vnode.props.value);
		el[assignKey] = getModelAssigner(vnode);
		addEventListener(el, "change", () => {
			el[assignKey](getValue(el));
		});
	},
	beforeUpdate(el, { value, oldValue }, vnode) {
		el[assignKey] = getModelAssigner(vnode);
		if (value !== oldValue) el.checked = looseEqual(value, vnode.props.value);
	}
};
var vModelSelect = {
	deep: true,
	created(el, { value, modifiers: { number } }, vnode) {
		const isSetModel = isSet(value);
		addEventListener(el, "change", () => {
			const selectedVal = Array.prototype.filter.call(el.options, (o) => o.selected).map((o) => number ? looseToNumber(getValue(o)) : getValue(o));
			el[assignKey](el.multiple ? isSetModel ? new Set(selectedVal) : selectedVal : selectedVal[0]);
			el._assigning = true;
			nextTick(() => {
				el._assigning = false;
			});
		});
		el[assignKey] = getModelAssigner(vnode);
	},
	mounted(el, { value, modifiers: { number } }) {
		setSelected(el, value);
	},
	beforeUpdate(el, _binding, vnode) {
		el[assignKey] = getModelAssigner(vnode);
	},
	updated(el, { value, modifiers: { number } }) {
		if (!el._assigning) setSelected(el, value);
	}
};
function setSelected(el, value, number) {
	const isMultiple = el.multiple;
	const isArrayValue = isArray$1(value);
	if (isMultiple && !isArrayValue && !isSet(value)) return;
	for (let i = 0, l = el.options.length; i < l; i++) {
		const option = el.options[i];
		const optionValue = getValue(option);
		if (isMultiple) if (isArrayValue) {
			const optionType = typeof optionValue;
			if (optionType === "string" || optionType === "number") option.selected = value.some((v) => String(v) === String(optionValue));
			else option.selected = looseIndexOf(value, optionValue) > -1;
		} else option.selected = value.has(optionValue);
		else if (looseEqual(getValue(option), value)) {
			if (el.selectedIndex !== i) el.selectedIndex = i;
			return;
		}
	}
	if (!isMultiple && el.selectedIndex !== -1) el.selectedIndex = -1;
}
function getValue(el) {
	return "_value" in el ? el._value : el.value;
}
function getCheckboxValue(el, checked) {
	const key = checked ? "_trueValue" : "_falseValue";
	return key in el ? el[key] : checked;
}
var vModelDynamic = {
	created(el, binding, vnode) {
		callModelHook(el, binding, vnode, null, "created");
	},
	mounted(el, binding, vnode) {
		callModelHook(el, binding, vnode, null, "mounted");
	},
	beforeUpdate(el, binding, vnode, prevVNode) {
		callModelHook(el, binding, vnode, prevVNode, "beforeUpdate");
	},
	updated(el, binding, vnode, prevVNode) {
		callModelHook(el, binding, vnode, prevVNode, "updated");
	}
};
function resolveDynamicModel(tagName, type) {
	switch (tagName) {
		case "SELECT": return vModelSelect;
		case "TEXTAREA": return vModelText;
		default: switch (type) {
			case "checkbox": return vModelCheckbox;
			case "radio": return vModelRadio;
			default: return vModelText;
		}
	}
}
function callModelHook(el, binding, vnode, prevVNode, hook) {
	const fn = resolveDynamicModel(el.tagName, vnode.props && vnode.props.type)[hook];
	fn && fn(el, binding, vnode, prevVNode);
}
function initVModelForSSR() {
	vModelText.getSSRProps = ({ value }) => ({ value });
	vModelRadio.getSSRProps = ({ value }, vnode) => {
		if (vnode.props && looseEqual(vnode.props.value, value)) return { checked: true };
	};
	vModelCheckbox.getSSRProps = ({ value }, vnode) => {
		if (isArray$1(value)) {
			if (vnode.props && looseIndexOf(value, vnode.props.value) > -1) return { checked: true };
		} else if (isSet(value)) {
			if (vnode.props && value.has(vnode.props.value)) return { checked: true };
		} else if (value) return { checked: true };
	};
	vModelDynamic.getSSRProps = (binding, vnode) => {
		if (typeof vnode.type !== "string") return;
		const modelToUse = resolveDynamicModel(vnode.type.toUpperCase(), vnode.props && vnode.props.type);
		if (modelToUse.getSSRProps) return modelToUse.getSSRProps(binding, vnode);
	};
}
var systemModifiers = [
	"ctrl",
	"shift",
	"alt",
	"meta"
];
var modifierGuards = {
	stop: (e) => e.stopPropagation(),
	prevent: (e) => e.preventDefault(),
	self: (e) => e.target !== e.currentTarget,
	ctrl: (e) => !e.ctrlKey,
	shift: (e) => !e.shiftKey,
	alt: (e) => !e.altKey,
	meta: (e) => !e.metaKey,
	left: (e) => "button" in e && e.button !== 0,
	middle: (e) => "button" in e && e.button !== 1,
	right: (e) => "button" in e && e.button !== 2,
	exact: (e, modifiers) => systemModifiers.some((m) => e[`${m}Key`] && !modifiers.includes(m))
};
var withModifiers = (fn, modifiers) => {
	const cache = fn._withMods || (fn._withMods = {});
	const cacheKey = modifiers.join(".");
	return cache[cacheKey] || (cache[cacheKey] = (event, ...args) => {
		for (let i = 0; i < modifiers.length; i++) {
			const guard = modifierGuards[modifiers[i]];
			if (guard && guard(event, modifiers)) return;
		}
		return fn(event, ...args);
	});
};
var keyNames = {
	esc: "escape",
	space: " ",
	up: "arrow-up",
	left: "arrow-left",
	right: "arrow-right",
	down: "arrow-down",
	delete: "backspace"
};
var withKeys = (fn, modifiers) => {
	const cache = fn._withKeys || (fn._withKeys = {});
	const cacheKey = modifiers.join(".");
	return cache[cacheKey] || (cache[cacheKey] = (event) => {
		if (!("key" in event)) return;
		const eventKey = hyphenate(event.key);
		if (modifiers.some((k) => k === eventKey || keyNames[k] === eventKey)) return fn(event);
	});
};
var rendererOptions = /* @__PURE__ */ extend({ patchProp }, nodeOps);
var renderer;
var enabledHydration = false;
function ensureRenderer() {
	return renderer || (renderer = createRenderer(rendererOptions));
}
function ensureHydrationRenderer() {
	renderer = enabledHydration ? renderer : createHydrationRenderer(rendererOptions);
	enabledHydration = true;
	return renderer;
}
var render = (...args) => {
	ensureRenderer().render(...args);
};
var hydrate = (...args) => {
	ensureHydrationRenderer().hydrate(...args);
};
var createApp = (...args) => {
	const app = ensureRenderer().createApp(...args);
	const { mount } = app;
	app.mount = (containerOrSelector) => {
		const container = normalizeContainer(containerOrSelector);
		if (!container) return;
		const component = app._component;
		if (!isFunction(component) && !component.render && !component.template) component.template = container.innerHTML;
		container.innerHTML = "";
		const proxy = mount(container, false, resolveRootNamespace(container));
		if (container instanceof Element) {
			container.removeAttribute("v-cloak");
			container.setAttribute("data-v-app", "");
		}
		return proxy;
	};
	return app;
};
var createSSRApp = (...args) => {
	const app = ensureHydrationRenderer().createApp(...args);
	const { mount } = app;
	app.mount = (containerOrSelector) => {
		const container = normalizeContainer(containerOrSelector);
		if (container) return mount(container, true, resolveRootNamespace(container));
	};
	return app;
};
function resolveRootNamespace(container) {
	if (container instanceof SVGElement) return "svg";
	if (typeof MathMLElement === "function" && container instanceof MathMLElement) return "mathml";
}
function normalizeContainer(container) {
	if (isString(container)) return document.querySelector(container);
	return container;
}
var ssrDirectiveInitialized = false;
var initDirectivesForSSR = () => {
	if (!ssrDirectiveInitialized) {
		ssrDirectiveInitialized = true;
		initVModelForSSR();
		initVShowForSSR();
	}
};
//#endregion
//#region node_modules/vue/dist/vue.runtime.esm-bundler.js
var vue_runtime_esm_bundler_exports = /* @__PURE__ */ __exportAll({
	BaseTransition: () => BaseTransition,
	BaseTransitionPropsValidators: () => BaseTransitionPropsValidators,
	Comment: () => Comment,
	DeprecationTypes: () => null,
	EffectScope: () => EffectScope,
	ErrorCodes: () => ErrorCodes,
	ErrorTypeStrings: () => ErrorTypeStrings,
	Fragment: () => Fragment,
	KeepAlive: () => KeepAlive,
	ReactiveEffect: () => ReactiveEffect,
	Static: () => Static,
	Suspense: () => Suspense,
	Teleport: () => Teleport,
	Text: () => Text,
	TrackOpTypes: () => TrackOpTypes,
	Transition: () => Transition,
	TransitionGroup: () => TransitionGroup,
	TriggerOpTypes: () => TriggerOpTypes,
	VueElement: () => VueElement,
	assertNumber: () => assertNumber,
	callWithAsyncErrorHandling: () => callWithAsyncErrorHandling,
	callWithErrorHandling: () => callWithErrorHandling,
	camelize: () => camelize,
	capitalize: () => capitalize,
	cloneVNode: () => cloneVNode,
	compatUtils: () => null,
	compile: () => compile,
	computed: () => computed,
	createApp: () => createApp,
	createBlock: () => createBlock,
	createCommentVNode: () => createCommentVNode,
	createElementBlock: () => createElementBlock,
	createElementVNode: () => createBaseVNode,
	createHydrationRenderer: () => createHydrationRenderer,
	createPropsRestProxy: () => createPropsRestProxy,
	createRenderer: () => createRenderer,
	createSSRApp: () => createSSRApp,
	createSlots: () => createSlots,
	createStaticVNode: () => createStaticVNode,
	createTextVNode: () => createTextVNode,
	createVNode: () => createVNode,
	customRef: () => customRef,
	defineAsyncComponent: () => defineAsyncComponent,
	defineComponent: () => defineComponent,
	defineCustomElement: () => defineCustomElement,
	defineEmits: () => defineEmits,
	defineExpose: () => defineExpose,
	defineModel: () => defineModel,
	defineOptions: () => defineOptions,
	defineProps: () => defineProps,
	defineSSRCustomElement: () => defineSSRCustomElement,
	defineSlots: () => defineSlots,
	devtools: () => devtools,
	effect: () => effect,
	effectScope: () => effectScope,
	getCurrentInstance: () => getCurrentInstance,
	getCurrentScope: () => getCurrentScope,
	getTransitionRawChildren: () => getTransitionRawChildren,
	guardReactiveProps: () => guardReactiveProps,
	h: () => h,
	handleError: () => handleError,
	hasInjectionContext: () => hasInjectionContext,
	hydrate: () => hydrate,
	initCustomFormatter: () => initCustomFormatter,
	initDirectivesForSSR: () => initDirectivesForSSR,
	inject: () => inject,
	isMemoSame: () => isMemoSame,
	isProxy: () => isProxy,
	isReactive: () => isReactive,
	isReadonly: () => isReadonly,
	isRef: () => isRef,
	isRuntimeOnly: () => isRuntimeOnly,
	isShallow: () => isShallow,
	isVNode: () => isVNode,
	markRaw: () => markRaw,
	mergeDefaults: () => mergeDefaults,
	mergeModels: () => mergeModels,
	mergeProps: () => mergeProps,
	nextTick: () => nextTick,
	normalizeClass: () => normalizeClass,
	normalizeProps: () => normalizeProps,
	normalizeStyle: () => normalizeStyle,
	onActivated: () => onActivated,
	onBeforeMount: () => onBeforeMount,
	onBeforeUnmount: () => onBeforeUnmount,
	onBeforeUpdate: () => onBeforeUpdate,
	onDeactivated: () => onDeactivated,
	onErrorCaptured: () => onErrorCaptured,
	onMounted: () => onMounted,
	onRenderTracked: () => onRenderTracked,
	onRenderTriggered: () => onRenderTriggered,
	onScopeDispose: () => onScopeDispose,
	onServerPrefetch: () => onServerPrefetch,
	onUnmounted: () => onUnmounted,
	onUpdated: () => onUpdated,
	openBlock: () => openBlock,
	popScopeId: () => popScopeId,
	provide: () => provide,
	proxyRefs: () => proxyRefs,
	pushScopeId: () => pushScopeId,
	queuePostFlushCb: () => queuePostFlushCb,
	reactive: () => reactive,
	readonly: () => readonly,
	ref: () => ref,
	registerRuntimeCompiler: () => registerRuntimeCompiler,
	render: () => render,
	renderList: () => renderList,
	renderSlot: () => renderSlot,
	resolveComponent: () => resolveComponent,
	resolveDirective: () => resolveDirective,
	resolveDynamicComponent: () => resolveDynamicComponent,
	resolveFilter: () => null,
	resolveTransitionHooks: () => resolveTransitionHooks,
	setBlockTracking: () => setBlockTracking,
	setDevtoolsHook: () => setDevtoolsHook,
	setTransitionHooks: () => setTransitionHooks,
	shallowReactive: () => shallowReactive,
	shallowReadonly: () => shallowReadonly,
	shallowRef: () => shallowRef,
	ssrContextKey: () => ssrContextKey,
	ssrUtils: () => ssrUtils,
	stop: () => stop,
	toDisplayString: () => toDisplayString,
	toHandlerKey: () => toHandlerKey,
	toHandlers: () => toHandlers,
	toRaw: () => toRaw,
	toRef: () => toRef,
	toRefs: () => toRefs,
	toValue: () => toValue,
	transformVNodeArgs: () => transformVNodeArgs,
	triggerRef: () => triggerRef,
	unref: () => unref,
	useAttrs: () => useAttrs,
	useCssModule: () => useCssModule,
	useCssVars: () => useCssVars,
	useModel: () => useModel,
	useSSRContext: () => useSSRContext,
	useSlots: () => useSlots,
	useTransitionState: () => useTransitionState,
	vModelCheckbox: () => vModelCheckbox,
	vModelDynamic: () => vModelDynamic,
	vModelRadio: () => vModelRadio,
	vModelSelect: () => vModelSelect,
	vModelText: () => vModelText,
	vShow: () => vShow,
	version: () => version,
	warn: () => warn,
	watch: () => watch,
	watchEffect: () => watchEffect,
	watchPostEffect: () => watchPostEffect,
	watchSyncEffect: () => watchSyncEffect,
	withAsyncContext: () => withAsyncContext,
	withCtx: () => withCtx,
	withDefaults: () => withDefaults,
	withDirectives: () => withDirectives,
	withKeys: () => withKeys,
	withMemo: () => withMemo,
	withModifiers: () => withModifiers,
	withScopeId: () => withScopeId
});
var compile = () => {};
//#endregion
//#region src/lib/util/check.ts
var check_exports = /* @__PURE__ */ __exportAll({ is_local: () => is_local });
var is_local = () => {
	return ["127.0.0.1", "localhost"].includes(window.location.hostname);
};
//#endregion
//#region src/lib/store/wshandler.ts
var wsjsonHandler = (msg) => {};
var wsbinHandler = async (msg) => {
	await msg.arrayBuffer();
	let headertype = "moment";
	switch (true) {
		case headertype == "moment": break;
	}
};
//#endregion
//#region src/lib/util/bin.ts
var bin_exports = /* @__PURE__ */ __exportAll({
	ArrayBuffer__base64: () => ArrayBuffer__base64,
	ArrayBuffer__hex: () => ArrayBuffer__hex,
	BytesBuilder: () => BytesBuilder,
	DateTime__bin: () => DateTime__bin,
	Json__bin: () => Json__bin,
	List__bin: () => List__bin,
	Mors__BytesBuilder: () => Mors__BytesBuilder,
	SpotInStat__bin: () => SpotInStat__bin,
	SpotInStat_empty: () => SpotInStat_empty,
	Stat__bin: () => Stat__bin,
	Stat_empty: () => Stat_empty,
	arrayBuffer__Hex: () => arrayBuffer__Hex,
	array__bin: () => array__bin,
	bin__DateTime: () => bin__DateTime,
	bin__Json: () => bin__Json,
	bin__List: () => bin__List,
	bin__SpotInStat: () => bin__SpotInStat,
	bin__Stat: () => bin__Stat,
	bin__array: () => bin__array,
	bin__bool: () => bin__bool,
	bin__boolarray: () => bin__boolarray,
	bin__dict: () => bin__dict,
	bin__float: () => bin__float,
	bin__int32: () => bin__int32,
	bin__int32array: () => bin__int32array,
	bin__int64: () => bin__int64,
	bin__int64array: () => bin__int64array,
	bin__option: () => bin__option,
	bin__str: () => bin__str,
	bool__bin: () => bool__bin,
	data__base64: () => data__base64,
	dict__KeyArray: () => dict__KeyArray,
	dict__ValArray: () => dict__ValArray,
	dict__bin: () => dict__bin,
	dict__kvpArray: () => dict__kvpArray,
	float__bin: () => float__bin,
	int32__bin: () => int32__bin,
	int32__binL: () => int32__binL,
	int64__bin: () => int64__bin,
	option__bin: () => option__bin,
	str__bin: () => str__bin,
	string__ArrayBuffer: () => string__ArrayBuffer
});
var BytesBuilder = class {
	count;
	buffer;
	constructor() {
		this.buffer = [];
		this.count = 0;
	}
	append(bin) {
		this.buffer.push(bin);
		this.count += bin.byteLength;
	}
	bytes() {
		let res = new ArrayBuffer(this.count);
		let i = 0;
		this.buffer.forEach((bin) => {
			new Uint8Array(res).set(new Uint8Array(bin), i);
			i += bin.byteLength;
		});
		return res;
	}
	base64() {
		return ArrayBuffer__base64(this.bytes());
	}
};
var Mors__BytesBuilder = (fn) => (data) => {
	const bb = new BytesBuilder();
	fn(bb)(data);
	return bb;
};
var ArrayBuffer__base64 = (buffer) => {
	let bytes = new Uint8Array(buffer);
	let bstr = "";
	for (let i = 0; i < bytes.byteLength; i++) bstr += String.fromCharCode(bytes[i]);
	return btoa(bstr);
};
var data__base64 = (data__bin) => (data) => {
	return Mors__BytesBuilder(data__bin)(data).base64();
};
var ArrayBuffer__hex = (buffer) => {
	const uint8Array = new Uint8Array(buffer);
	let hexString = "";
	for (let i = 0; i < uint8Array.length; i++) {
		const hex = uint8Array[i].toString(16).padStart(2, "0");
		hexString += hex + " ";
	}
	return hexString.trim();
};
var string__ArrayBuffer = (str) => {
	const stringLength = str.length;
	const buffer = /* @__PURE__ */ new ArrayBuffer(stringLength * 2);
	const bufferView = new Uint16Array(buffer);
	for (let i = 0; i < stringLength; i++) bufferView[i] = str.charCodeAt(i);
	return buffer;
};
var int32__binL = (bb) => (v) => {
	const bin = new Int32Array([v]).buffer;
	bb.append(bin);
};
var int32__bin = (bb) => (v) => {
	const buffer = /* @__PURE__ */ new ArrayBuffer(4);
	new DataView(buffer).setInt32(0, v, true);
	bb.append(buffer);
};
var bin__int32 = (bi, littleEndian = true) => {
	const res = new DataView(bi.bin).getInt32(bi.index, littleEndian);
	bi.index += 4;
	return res;
};
var int64__bin = (bb) => (v) => {
	if (typeof v == "number") v = BigInt(v);
	const buffer = /* @__PURE__ */ new ArrayBuffer(8);
	new DataView(buffer).setBigInt64(0, v, true);
	bb.append(buffer);
};
var bin__int64 = (bi, littleEndian = true) => {
	const res = new DataView(bi.bin).getBigInt64(bi.index, littleEndian);
	bi.index += 8;
	return Number(res);
};
var DateTime__bin = (bb) => (v) => {
	const checkDate = (v) => {
		if (typeof v == "number") return v;
		else try {
			return v.getTime();
		} catch {
			console.log(`something wrong with ${v}, return current Date.`);
			return /* @__PURE__ */ new Date();
		}
	};
	console.log("v=" + v);
	const timestamp = BigInt(checkDate(v));
	const buffer = /* @__PURE__ */ new ArrayBuffer(8);
	new DataView(buffer).setBigInt64(0, timestamp, true);
	bb.append(buffer);
};
var bin__DateTime = (bi, littleEndian = true) => {
	const timestamp = new DataView(bi.bin).getBigInt64(bi.index, littleEndian);
	const res = new Date(Number(timestamp));
	bi.index += 8;
	return res;
};
var float__bin = (bb) => (v) => {
	const bin = new Float64Array([v]).buffer;
	bb.append(bin);
};
var bin__float = (bi) => {
	const res = new DataView(bi.bin).getFloat64(bi.index);
	bi.index += 8;
	return res;
};
var bool__bin = (bb) => (v) => {
	const bin = new Uint8Array([v ? 1 : 0]).buffer;
	bb.append(bin);
};
var bin__bool = (bi) => {
	const res = new DataView(bi.bin).getUint8(bi.index) === 1;
	bi.index += 1;
	return res;
};
var str__bin = (bb) => (str) => {
	const encoded = new TextEncoder().encode(str);
	const length = encoded.buffer.byteLength;
	int32__bin(bb)(length);
	bb.append(encoded.buffer);
};
var bin__str = (bi) => {
	const length = Number(bin__int32(bi));
	const decoder = new TextDecoder("utf-8");
	const bytes = new Uint8Array(bi.bin, bi.index + 4, length);
	const res = decoder.decode(bytes);
	bi.index += length + 4;
	return res;
};
var bin__Json = (bi) => {
	return JSON.stringify(bin__str(bi));
};
var Json__bin = (bb) => (obj) => {
	str__bin(bb)(JSON.stringify(obj));
};
var option__bin = (item__bin) => (bb) => (v) => {
	if (v) {
		bool__bin(bb)(true);
		item__bin(bb)(v);
	} else bool__bin(bb)(false);
};
var bin__option = (bin__item) => (bi) => {
	if (bin__bool(bi)) return bin__item(bi);
	else return null;
};
var array__bin = (item__bin) => (bb) => (array) => {
	int32__bin(bb)(array.length);
	array.forEach((i) => {
		item__bin(bb)(i);
	});
};
var bin__array = (bin__item) => (bi) => {
	let res = [];
	if (bi.bin.byteLength >= 4) {
		let length = bin__int32(bi);
		for (let i = 0; i < length; i++) {
			let item = bin__item(bi);
			res.push(item);
		}
	}
	return res;
};
var bin__int32array = bin__array(bin__int32);
var bin__int64array = bin__array(bin__int64);
var bin__boolarray = bin__array(bin__bool);
var List__bin = (item__bin) => (bb) => (array) => {
	int32__bin(bb)(array.length);
	array.forEach((i) => {
		item__bin(bb)(i);
	});
};
var bin__List = (bin__item) => (bi) => {
	let res = [];
	if (bi.bin.byteLength >= 4) {
		let length = bin__int32(bi);
		for (let i = 0; i < length; i++) {
			let item = bin__item(bi);
			res.push(item);
		}
	}
	return res;
};
var dict__kvpArray = (dict) => {
	return Object.entries(dict).map(([k, v]) => ({
		k,
		v
	}));
};
var dict__bin = (k__bin) => (v__bin) => (bb) => (dict) => {
	const array = dict__kvpArray(dict);
	array__bin(() => {
		k__bin(bb);
		v__bin(bb);
	})(bb)(array);
};
var bin__dict = (bin__k) => (bin__v) => (bi) => {
	const dict = {};
	if (bi.bin.byteLength >= 4) {
		let length = bin__int32(bi);
		for (let i = 0; i < length; i++) {
			const k = bin__k(bi);
			dict[k] = bin__v(bi);
		}
	}
	return dict;
};
var arrayBuffer__Hex = (buffer) => {
	const view = new DataView(buffer);
	let hexString = "";
	for (let i = 0; i < view.byteLength; i++) {
		const hex = view.getUint8(i).toString(16).padStart(2, "0");
		hexString += hex;
	}
	return hexString.toUpperCase();
};
function dict__KeyArray(dict) {
	return Object.entries(dict).map(([k, v]) => k);
}
function dict__ValArray(dict) {
	return Object.entries(dict).map(([k, v]) => v);
}
var Stat_empty = () => {
	return {
		mean: 0,
		middle: 0,
		var: 0,
		median: 0,
		qinf: 0,
		qsup: 0,
		oinf: 0,
		osup: 0,
		inf: 0,
		sup: 0,
		histogram: [],
		count: 0
	};
};
var Stat__bin = (bb) => (v) => {
	float__bin(bb)(v.mean);
	float__bin(bb)(v.middle);
	float__bin(bb)(v.var);
	float__bin(bb)(v.median);
	float__bin(bb)(v.qinf);
	float__bin(bb)(v.qsup);
	float__bin(bb)(v.oinf);
	float__bin(bb)(v.osup);
	float__bin(bb)(v.inf);
	float__bin(bb)(v.sup);
	array__bin(int32__bin)(bb);
	int32__bin(bb)(v.count);
};
var bin__Stat = (bi) => {
	return {
		mean: bin__float(bi),
		middle: bin__float(bi),
		var: bin__float(bi),
		median: bin__float(bi),
		qinf: bin__float(bi),
		qsup: bin__float(bi),
		oinf: bin__float(bi),
		osup: bin__float(bi),
		inf: bin__float(bi),
		sup: bin__float(bi),
		histogram: bin__array(bin__int32)(bi),
		count: bin__int32(bi)
	};
};
var SpotInStat_empty = () => {
	return {
		deviation: 0,
		spot: 0,
		anchor: 0,
		digit: 0,
		unit: "",
		stat: Stat_empty()
	};
};
var SpotInStat__bin = (bb) => (v) => {
	float__bin(bb)(v.deviation);
	float__bin(bb)(v.spot);
	float__bin(bb)(v.anchor);
	int32__bin(bb)(v.digit);
	str__bin(bb)(v.unit);
	Stat__bin(bb)(v.stat);
};
var bin__SpotInStat = (bi) => {
	return {
		deviation: bin__float(bi),
		spot: bin__float(bi),
		anchor: bin__float(bi),
		digit: bin__int32(bi),
		unit: bin__str(bi),
		stat: bin__Stat(bi)
	};
};
//#endregion
//#region src/lib/util/ws.ts
var ws_exports = /* @__PURE__ */ __exportAll({
	createWebSocket: () => createWebSocket,
	disconnect: () => disconnect,
	tryApiRequest: () => tryApiRequest,
	trySend: () => trySend,
	trySendx: () => trySendx
});
var tryJSONobj = (data) => {
	try {
		return JSON.parse(data);
	} catch (e) {
		return data;
	}
};
var createWebSocket_base = (wsbinHandler, wsjsonHandler) => (wsurl) => (savetoRT = "ws.conn") => {
	const ws = new WebSocket(wsurl);
	ws.onopen = (event) => {
		console.log("WebSocket connected");
	};
	ws.onclose = (event) => {
		console.log("WebSocket closed");
		setTimeout(() => {
			glib.setRT(savetoRT, glib.ws.createWebSocket(wsurl)(savetoRT));
		}, 3e3);
	};
	ws.onerror = (event) => {
		console.error("WebSocket error:", event);
	};
	ws.onmessage = (event) => {
		let msg = event.data;
		switch (true) {
			case typeof msg == "string":
				msg = tryJSONobj(msg);
				if (typeof msg !== "string") wsjsonHandler(msg);
				else console.log(msg);
				break;
			default:
				wsbinHandler(msg);
				break;
		}
	};
	glib.setRT(savetoRT, ws);
	return ws;
};
var createWebSocket = createWebSocket_base(wsbinHandler, wsjsonHandler);
var disconnect = (ws = rtxx.wsctx) => {
	if (ws.ws && ws.ws.readyState === WebSocket.OPEN) ws.ws.close();
};
var trySend = (x) => (e) => (msg) => {
	if (!x) x = rtxx.wsctx;
	if (x && x.ws.readyState === WebSocket.OPEN) {
		const bb = new BytesBuilder();
		glib.Mor.Msg__bin(bb)({
			e: 1,
			val: msg
		});
		x.ws.send(bb.bytes());
	}
};
var trySendx = (e) => (msg) => {
	trySend(rtxx.wsctx)(e)(msg);
};
var tryApiRequest = async (req, rep) => {
	trySendx(glib.Mor.MsgEnum.ApiRequest)(req);
};
//#endregion
//#region src/lib/util/markdown.ts
var markdown_exports = /* @__PURE__ */ __exportAll({
	html__toc: () => html__toc,
	markdown__html: () => markdown__html,
	markdown__html_: () => markdown__html_
});
var escape_html = (html) => {
	return html.replace(/</g, "&lt;").replace(/>/g, "&gt;");
};
var parse_md = (str) => {
	const bold = str.match(/\*{2}[^*].*?\*{2}/g);
	if (bold) for (let i = 0, len = bold.length; i < len; i++) str = str.replace(bold[i], `<strong>${bold[i].substring(2, bold[i].length - 2)}</strong>`);
	const italic = str.match(/\*[^*].*?\*/g);
	if (italic) for (let i = 0, len = italic.length; i < len; i++) str = str.replace(italic[i], `<em>${italic[i].substring(1, italic[i].length - 1)}</em>`);
	const code = str.match(/`[^`]*`/g);
	if (code) for (let i = 0, len = code.length; i < len; i++) str = str.replace(code[i], `<code>${code[i].substring(1, code[i].length - 1)} </code>`);
	const url_regex = /\(.*\)/;
	const title_regex = /\[.*\]/;
	const img = str.match(/!\[.*\]\(.*\)/g);
	if (img) for (let i = 0, len = img.length; i < len; i++) {
		let url = img[i].match(url_regex)?.[0] || "";
		let title = img[i].match(title_regex)?.[0] || "";
		title = escape_html(title.substring(1, title.length - 1));
		str = str.replace(img[i], `<img src="${url}" alt="${title}">`);
	}
	const a = str.match(/\[.*?\]\(.*?\)/g);
	if (a) for (let i = 0, len = a.length; i < len; i++) {
		let url = a[i].match(url_regex)?.[0] || "";
		let title = a[i].match(title_regex)?.[0] || "";
		url = url.substring(1, url.length - 1);
		title = escape_html(title.substring(1, title.length - 1));
		str = str.replace(a[i], `<a href="${url}" title="${title}">${title}</a>`);
	}
	const tag = str.match(/\[\[(.*?)\]\]/g);
	if (tag) for (let i = 0, len = tag.length; i < len; i++) {
		const tagPart = tag[i].substring(2, tag[i].length - 2).split(":");
		const word = tagPart.length === 2 ? tagPart[1] : tagPart[0];
		const lang = tagPart.length === 2 ? tagPart[0] : "zh";
		str = str.replace(tag[i], `<a href="/community/${lang}:${word}" title="${word}" class="tag">${word}</a>`);
	}
	const youtube = str.match(/^(https):\/\/?((www\.)?youtube\.com|youtu\.be)\/.+$/gi);
	if (youtube) for (let i = 0, len = youtube.length; i < len; i++) {
		let youtubeEmbedUrl = youtube[i].replace("https://www.youtube.com/watch?v=", "https://www.youtube.com/").replace("https://youtube.com/shorts/", "https://www.youtube.com/").replace("https://www.youtube.com/", "https://www.youtube.com/embed/").replace("https://youtu.be/", "https://www.youtube.com/embed/");
		if (youtube[i].includes("list")) youtubeEmbedUrl = youtube[i].replace("https://www.youtube.com/", "https://www.youtube.com/embed/");
		str = str.replace(youtube[i], `<iframe src="${youtubeEmbedUrl}" frameborder="0" title="YouTube video player"
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen class="youtube-video"></iframe>`);
	}
	const twitter = str.match(/^((https?):\/\/)?(www.)?(twitter|x)\.com(\/@?(\w){1,15})\/status\/[0-9]{19}(\?.+)?$/gi);
	if (twitter) for (let i = 0, len = twitter.length; i < len; i++) {
		const twitterUrl = twitter[i].replace("x.com", "twitter.com");
		str = str.replace(twitter[i], `<blockquote class="twitter-tweet"><a href="${twitterUrl}"></a></blockquote>`);
	}
	const spotify = str.match(/^(https):\/\/?(open\.spotify\.com)\/(playlist|track|album)\/.+$/gi);
	if (spotify) for (let i = 0, len = spotify.length; i < len; i++) {
		const spotifyEmbedUrl = spotify[i].replace("track", "embed/track").replace("album", "embed/album").replace("playlist", "embed/playlist").split("?")[0] + "?utm_source=generator&theme=0";
		const isPlayList = spotifyEmbedUrl.includes("playlist") || spotifyEmbedUrl.includes("album");
		str = str.replace(spotify[i], `<iframe src="${spotifyEmbedUrl}" frameborder="0" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture"
            allowfullscreen loading="lazy" class="spotify-embed" height="${isPlayList ? "380px" : "352px"}"></iframe>`);
	}
	const itunes = str.match(/^(https):\/\/?(music\.apple\.com)\/[a-z]{2}\/(playlist|album)\/.+$/gi);
	if (itunes) for (let i = 0, len = itunes.length; i < len; i++) {
		const itunesEmbedUrl = itunes[i].replace("music.apple.com", "embed.music.apple.com");
		const isPlayList = itunesEmbedUrl.includes("playlist") || itunesEmbedUrl.includes("album");
		str = str.replace(itunes[i], `<iframe src="${itunesEmbedUrl}" frameborder="0" allow="autoplay *; encrypted-media *; fullscreen *; clipboard-write"
            sandbox="allow-forms allow-popups allow-same-origin allow-scripts allow-storage-access-by-user-activation allow-top-navigation-by-user-activation"
            class="itunes-embed" height="${isPlayList ? "450px" : "175px"}"></iframe>`);
	}
	str = str.replace(/\\\$/g, "$");
	return str;
};
var compile_md = (p) => {
	let matchArr;
	let html = "";
	for (let i = 0, len = p.length; i < len; i++) {
		const text = p[i];
		const index = i;
		matchArr = text.match(/^#\s/) || text.match(/^##\s/) || text.match(/^###\s/) || text.match(/^####\s/) || text.match(/^#####\s/) || text.match(/^######\s/) || text.match(/^\*{3,}/) || text.match(/^-{3,}/) || text.match(/^>\s/) || text.match(/^\*\s/) || text.match(/^\d*\.\s/) || text.match(/^```/) || text.match(/^\|.*\|/) || text.match(/^\$\$/) || text.match(/(^|[^\\])\$(?![\\$])([^$\\]*[^\\$ ])\$/);
		if (matchArr) {
			let temp = "";
			const re1 = /^>/;
			const re2 = /^\*\s/;
			const re3 = /^\d*\.\s/;
			const re4 = /^```/;
			const re5 = /^\|.*\|/;
			const re6 = /^\$\$/;
			switch (matchArr[0]) {
				case "# ":
					html += `<h1 id="link-${index}">${parse_md(text.substring(2))}</h1>`;
					break;
				case "## ":
					html += `<h2 id="link-${index}">${parse_md(text.substring(3))}</h2>`;
					break;
				case "### ":
					html += `<h3 id="link-${index}">${parse_md(text.substring(4))}</h3>`;
					break;
				case "#### ":
					html += `<h4 id="link-${index}">${parse_md(text.substring(5))}</h4>`;
					break;
				case "##### ":
					html += `<h5 id="link-${index}">${parse_md(text.substring(6))}</h5>`;
					break;
				case "###### ":
					html += `<h6 id="link-${index}">${parse_md(text.substring(7))}</h6>`;
					break;
				case text.match(/^\*{3,}/) && text.match(/^\*{3,}/)?.[0]:
					html += text.replace(/^\*{3,}/g, "<hr />");
					break;
				case text.match(/^-{3,}/) && text.match(/^-{3,}/)?.[0]:
					html += text.replace(/^-{3,}/g, "<hr />");
					break;
				case "> ":
					while (i < len && p[i].match(re1)) {
						const str = p[i];
						temp += parse_md(str.slice(1));
						temp += `<br />`;
						i++;
					}
					i--;
					html += `<blockquote>${temp}</blockquote>`;
					break;
				case "* ":
					while (i < len && p[i].match(re2)) {
						const str = p[i];
						temp += `<li>${parse_md(str.slice(2))}</li>`;
						i++;
					}
					i--;
					html += `<ul>${temp}</ul>`;
					break;
				case text.match(/^\d*\.\s/) && text.match(/^\d*\.\s/)?.[0]:
					while (i < len && p[i].match(re3)) {
						const str = p[i];
						temp += `<li>${parse_md(str)}</li>`;
						i++;
					}
					i--;
					html += `<ol>${temp}</ol>`;
					break;
				case "```":
					i++;
					while (i < len && !re4.test(p[i])) {
						temp += escape_html(p[i]);
						temp += "\n";
						i++;
					}
					html += `<pre><code>${temp}</code></pre>`;
					break;
				case text.match(/^\|.*\|/) && text.match(/^\|.*\|/)?.[0]: {
					const th_regex = /^\[th\]/;
					let arr, j, jlen;
					while (i < len && re5.test(p[i])) {
						arr = p[i].split("|");
						temp += `<tr>`;
						for (j = 1, jlen = arr.length - 1; j < jlen; j++) if (th_regex.test(arr[1])) temp += `<th>${parse_md(arr[j])}</th>`;
						else temp += `<td>${parse_md(arr[j])}</td>`;
						temp += "</tr>";
						i++;
					}
					html += `<table>${temp}</table>`;
					break;
				}
				case "$$":
					i++;
					while (i < len && !re6.test(p[i])) {
						temp += escape_html(p[i]);
						i++;
					}
			}
		} else if (text) html += `<p>${parse_md(escape_html(text))}</p>`;
	}
	return html;
};
var markdown__html = (str) => {
	let res = "";
	let lines = str.split(/\r?\n/);
	let state = "";
	let buffer = [];
	for (let i = 0, len = lines.length; i < len; i++) {
		let line = lines[i];
		let html = "";
		if (state == "" && line.startsWith("$$")) {
			state = "$$";
			continue;
		} else if (state == "$$" && line.startsWith("$$")) {
			let s = buffer.join("");
			console.log(s);
			let tex = encodeURI(s);
			console.log(tex);
			let alt = s.replaceAll("\"", " ").replaceAll("'", " ").replaceAll("<", " ").replaceAll(">", " ");
			let p = "<p>" + ("<img class='img-inline' src='http://latex.codecogs.com/gif.latex?" + tex + "' alt='" + alt + "'>") + "&nbsp;</p>";
			res += p;
			buffer = [];
			state = "";
			continue;
		} else if (state == "$$") {
			buffer.push(line);
			continue;
		}
		line.matchAll(/\$.+?\$/g).forEach((item) => {
			let s = item + "";
			let tex = encodeURI(s.substring(1, s.length - 1));
			let alt = s.substring(1, s.length - 1).replaceAll("\"", " ").replaceAll("'", " ").replaceAll("<", " ").replaceAll(">", " ");
			let img = "<img class='img-inline' src='http://latex.codecogs.com/gif.latex?" + tex + "' alt='" + alt + "'>";
			line = line.replace(s, img);
		});
		line.matchAll(/\!\[.*?\]\(.+?\)/g).forEach((item) => {
			let s = item + "";
			let txt = s.match(/\[.+?\]/) + "";
			if (txt.length >= 2) txt = txt.substring(1, txt.length - 1);
			let src = s.match(/\(.+?\)/) + "";
			if (src.length >= 2) src = src.substring(1, src.length - 1);
			let media = "<br><img src='" + src + "' alt='" + txt + "'><br>";
			if (src.endsWith(".mp3")) media = "<br><audio controls><source src='" + src + "' type='audio/mp3'></audio><br>";
			line = line.replace(s, media);
		});
		line.matchAll(/\[.+?\]\(.+?\)/g).forEach((item) => {
			let s = item + "";
			let txt = s.match(/\[.+?\]/) + "";
			let s1 = s;
			if (txt.length >= 2) {
				txt = txt.substring(1, txt.length - 1);
				s1 = s.substring(txt.length + 2);
			}
			let src = s1.match(/\(.+?\)/) + "";
			if (src.length >= 2) src = src.substring(1, src.length - 1);
			let a = "<a href='" + src + "' target='_blank'>" + txt + "</a>";
			line = line.replace(s, a);
		});
		line.matchAll(/\*\*.*?\*\*/g).forEach((item) => {
			let s = item + "";
			let b = "<b>" + s.substring(2, s.length - 2) + "</b>";
			line = line.replace(s, b);
		});
		if (line.startsWith("---")) html = "<hr>";
		else if (line.startsWith("##### ")) html = "<div class='caption-5'>" + line.substring(6, line.length) + "</div>";
		else if (line.startsWith("#### ")) html = "<div class='caption-4'>" + line.substring(5, line.length) + "</div>";
		else if (line.startsWith("### ")) html = "<div class='caption-3'>" + line.substring(4, line.length) + "</div>";
		else if (line.startsWith("## ")) html = "<div class='caption-2'>" + line.substring(3, line.length) + "</div>";
		else if (line.startsWith("# ")) html = "<div class='caption-1'>" + line.substring(2, line.length) + "</div>";
		else html = "<p>" + line + "&nbsp;</p>";
		res += html;
	}
	return res;
};
var markdown__html_ = (str) => {
	if (!str) str = "";
	try {
		return compile_md(str.split(/\r?\n/));
	} catch {
		compile_md([str]);
	}
	return "";
};
var html__toc = (html) => {
	const headings = new DOMParser().parseFromString(html, "text/html").querySelectorAll("h1, h2, h3, h4, h5, h6");
	const counter = [0];
	let tocHtml = "";
	headings.forEach((heading) => {
		const level = parseInt(heading.tagName.charAt(1));
		const text = heading.textContent;
		const id = heading.id;
		while (counter.length < level) counter.push(0);
		counter[level - 1]++;
		for (let i = level; i < counter.length; i++) counter[i] = 0;
		const listItem = `<li><a href="#${id}">${counter.slice(0, level).join(".")} ${text}</a></li>`;
		tocHtml += listItem;
	});
	return tocHtml;
};
//#endregion
//#region src/lib/util/graphics.ts
var graphics_exports = /* @__PURE__ */ __exportAll({
	Chart__CoordXY: () => Chart__CoordXY,
	RowCol__Cells: () => RowCol__Cells,
	Vct2_xOffset: () => Vct2_xOffset,
	Vct2_yOffset: () => Vct2_yOffset,
	chart__cellLayout: () => chart__cellLayout,
	chart__layout: () => chart__layout,
	checkPRange: () => checkPRange,
	checkmultiPRange: () => checkmultiPRange,
	colrowSpan__gridLayoutCell: () => colrowSpan__gridLayoutCell,
	colrow__gridLayoutCell: () => colrow__gridLayoutCell,
	d__p: () => d__p,
	p__d: () => p__d,
	percentage__controlPoints: () => percentage__controlPoints,
	pp__dd: () => pp__dd,
	pxy__dxy: () => pxy__dxy,
	strechPRange: () => strechPRange,
	wh__Chart: () => wh__Chart,
	xy__Vct2: () => xy__Vct2
});
var Vct2_xOffset = (v) => (x) => {
	return {
		x: v.x + x,
		y: v.y
	};
};
var Vct2_yOffset = (v) => (y) => {
	return {
		x: v.x,
		y: v.y + y
	};
};
var xy__Vct2 = (x, y) => {
	return {
		x,
		y
	};
};
var checkPRange = (coord) => (p) => {
	if (coord.pinf > p) coord.pinf = p;
	if (coord.psup < p) coord.psup = p;
};
var checkmultiPRange = (coord) => (ps) => {
	ps.forEach(checkPRange(coord));
};
var strechPRange = (coord) => (rate) => {
	let inf = coord.pinf;
	let sup = coord.psup;
	let middle = (inf + sup) / 2;
	let semirange = (sup - inf) / 2;
	coord.pinf = middle - rate * semirange;
	coord.psup = middle + rate * semirange;
};
var p__d = (coord) => (p) => {
	return coord.dinf + (coord.dsup - coord.dinf) * (p - coord.pinf) / (coord.psup - coord.pinf);
};
var d__p = (coord) => (d) => {
	return coord.pinf + (coord.psup - coord.pinf) * (d - coord.dinf) / (coord.dsup - coord.dinf);
};
var pp__dd = (coordx, coordy) => (px, py) => {
	return {
		x: p__d(coordx)(px),
		y: p__d(coordy)(py)
	};
};
var pxy__dxy = (coordxy) => (v) => {
	return {
		x: p__d(coordxy.x)(v.x),
		y: p__d(coordxy.y)(v.y)
	};
};
var Chart__CoordXY = (chart) => {
	return {
		x: {
			dinf: chart.l,
			dsup: chart.l + chart.w
		},
		y: {
			dinf: chart.t + chart.h,
			dsup: chart.t
		}
	};
};
var wh__Chart = (w, h) => {
	return {
		l: 0,
		t: 0,
		w: Number(w),
		h: Number(h)
	};
};
var colrowSpan__gridLayoutCell = (col, row, colspan, rowspan) => {
	return {
		col,
		row,
		colspan,
		rowspan
	};
};
var colrow__gridLayoutCell = (col, row) => {
	return {
		col,
		row,
		colspan: 1,
		rowspan: 1
	};
};
var percentage__controlPoints = (inf, sup) => (vs) => {
	let sum = 0;
	vs.forEach((v) => {
		sum += v;
	});
	let res = new Array(vs.length + 1);
	res[0] = inf;
	for (let i = 0; i < vs.length; i++) res[i + 1] = res[i] + (sup - inf) * vs[i] / sum;
	return res;
};
var chart__layout = (chart) => (xs, ys) => (grids) => {
	let layoutx = percentage__controlPoints(chart.l, chart.l + chart.w)(xs);
	let layouty = percentage__controlPoints(chart.t, chart.t + chart.h)(ys);
	let res = new Array(grids.length);
	for (let i = 0; i < grids.length; i++) {
		let grid = grids[i];
		res[i] = {
			l: layoutx[grid.col],
			t: layouty[grid.row],
			w: layoutx[grid.col + grid.colspan] - layoutx[grid.col],
			h: layouty[grid.row + grid.rowspan] - layouty[grid.row]
		};
	}
	return res;
};
var chart__cellLayout = (chart) => (xs, ys) => (cells) => {
	let grids = cells.map((i) => colrow__gridLayoutCell(i.x, i.y));
	return chart__layout(chart)(xs, ys)(grids);
};
var RowCol__Cells = (row, col) => {
	let res = new Array();
	for (let i = 0; i < row; i++) for (let j = 0; j < col; j++) res.push(xy__Vct2(j, i));
	return res;
};
//#endregion
//#region src/lib/util/fetch.ts
var checkUrl = (url) => {
	const getbase = () => {
		if (runtime.host.api) return runtime.host.api;
		return `https://localhost`;
	};
	if (/^http(s?):/i.test(url)) return url;
	const base = getbase();
	if (base.endsWith("/") && url.startsWith("/")) return base + url.slice(1);
	else if (!base.endsWith("/") && !url.startsWith("/") && base !== "") return base + "/" + url;
	return base + url;
};
var request = (method) => async (url, data) => {
	url = checkUrl(url);
	let clerkToken = null;
	if (window.Clerk?.session) clerkToken = await window.Clerk.session.getToken();
	const inits = {
		method,
		mode: "cors",
		headers: {
			"Content-Type": "application/json",
			"Authorization": clerkToken ? `Bearer ${clerkToken}` : ""
		}
	};
	switch (method) {
		case "POST":
			if (runtime.session) data["session"] = runtime.session;
			inits["body"] = JSON.stringify(data);
			break;
		case "GET":
			const queryString = new URLSearchParams(data).toString();
			url = queryString ? `${url}?${queryString}` : url;
			break;
	}
	return fetch(url, inits).then((res) => {
		return res.json();
	}).catch((err) => {
		console.error("Error:", err);
	});
};
var post = request("POST");
var get = request("GET");
//#endregion
//#region src/lib/util/misc.ts
var misc_exports = /* @__PURE__ */ __exportAll({
	sleep: () => sleep$1,
	url__Params: () => url__Params
});
var sleep$1 = (ms) => {
	return new Promise((resolve) => setTimeout(resolve, ms));
};
var url__Params = (url) => {
	const searchParams = new URLSearchParams(url.split("?")[1]);
	const params = {};
	for (const [key, value] of searchParams.entries()) params[key] = value;
	return params;
};
//#endregion
//#region src/lib/mod/auth.ts
var auth_exports = /* @__PURE__ */ __exportAll({
	LoginOption__RT: () => LoginOption__RT,
	SignOut: () => SignOut,
	biz__LoginOptions: () => biz__LoginOptions,
	host__DiscordRedirectURL: () => host__DiscordRedirectURL
});
var SignOut = () => {
	window.localStorage.clear();
	location.reload();
};
var biz__LoginOptions = (biz = "DISCORD") => {
	const options = {
		biz: biz.toUpperCase(),
		code: "",
		redirectUrl: rtxx.host.discordRedirect
	};
	options.code = new URLSearchParams(window.location.search).get("code");
	return options;
};
var LoginOption__RT = async (options) => {
	const res = await glib.post("/api/public/auth", options);
	if (res.session) {
		glib.notify.aSuc("Login Suc");
		rtxx.session = String(res.session);
		if (res.ec) rtxx.user = res.ec;
	}
	return res;
};
var authParams__URLQuery = (params) => {
	return Object.keys(params).map((key) => encodeURIComponent(key) + "=" + encodeURIComponent(params[key])).join("&");
};
var host__DiscordRedirectURL = (host = rtxx.host) => {
	return `https://discord.com/oauth2/authorize?${authParams__URLQuery({
		client_id: host.discordAPPID,
		response_type: "code",
		redirect_uri: host.discordRedirect,
		scope: "identify"
	})}`;
};
//#endregion
//#region src/lib/mod/notify.ts
var notify_exports = /* @__PURE__ */ __exportAll({
	DefaultItem: () => DefaultItem,
	Refresh: () => Refresh,
	aEx: () => aEx,
	aFail: () => aFail,
	aSuc: () => aSuc,
	add: () => add,
	getTimeleft: () => getTimeleft,
	getcurMsg: () => getcurMsg,
	init: () => init,
	msg_add: () => msg_add,
	onADDClick: () => onADDClick,
	removeExpiredMessages: () => removeExpiredMessages
});
var add = (msg) => {
	msg_add({ msg });
};
var aSuc = (msg, exp = 400) => {
	msg_add({
		msg,
		expire: exp,
		bgcolor: "bg-green-500/80"
	});
};
var aFail = (msg, exp = 1500) => {
	msg_add({
		msg,
		expire: exp,
		bgcolor: "bg-red-500/80"
	});
};
var aEx = (msg, exp = 1500) => {
	msg_add({
		msg,
		expire: exp,
		bgcolor: "bg-orange-500/80"
	});
};
var msg_add = (item) => {
	if (!item.msg) item.msg = `${Date.now()}MSG`;
	item.cdate = Date.now();
	if (!item.expire) item.expire = 3e3;
	if (!item.bgcolor) item.bgcolor = "bg-gray-500/70";
	item.expire = Date.now() + item.expire;
	Refresh();
};
var DefaultItem = () => {
	return { msg: `TEST ${Date.now()}` };
};
var getcurMsg = () => {
	return DefaultItem();
};
var getTimeleft = (item) => {
	return item.expire - Date.now();
};
var removeExpiredMessages = () => {};
var Refresh = () => {};
var init = () => {
	setInterval(Refresh, 500);
};
var onADDClick = () => {
	msg_add(DefaultItem());
};
//#endregion
//#region node_modules/vue-router/dist/vue-router.mjs
/*!
* vue-router v4.3.3
* (c) 2024 Eduardo San Martin Morote
* @license MIT
*/
var isBrowser = typeof document !== "undefined";
function isESModule(obj) {
	return obj.__esModule || obj[Symbol.toStringTag] === "Module";
}
var assign = Object.assign;
function applyToParams(fn, params) {
	const newParams = {};
	for (const key in params) {
		const value = params[key];
		newParams[key] = isArray(value) ? value.map(fn) : fn(value);
	}
	return newParams;
}
var noop = () => {};
/**
* Typesafe alternative to Array.isArray
* https://github.com/microsoft/TypeScript/pull/48228
*/
var isArray = Array.isArray;
/**
* Encoding Rules (␣ = Space)
* - Path: ␣ " < > # ? { }
* - Query: ␣ " < > # & =
* - Hash: ␣ " < > `
*
* On top of that, the RFC3986 (https://tools.ietf.org/html/rfc3986#section-2.2)
* defines some extra characters to be encoded. Most browsers do not encode them
* in encodeURI https://github.com/whatwg/url/issues/369, so it may be safer to
* also encode `!'()*`. Leaving un-encoded only ASCII alphanumeric(`a-zA-Z0-9`)
* plus `-._~`. This extra safety should be applied to query by patching the
* string returned by encodeURIComponent encodeURI also encodes `[\]^`. `\`
* should be encoded to avoid ambiguity. Browsers (IE, FF, C) transform a `\`
* into a `/` if directly typed in. The _backtick_ (`````) should also be
* encoded everywhere because some browsers like FF encode it when directly
* written while others don't. Safari and IE don't encode ``"<>{}``` in hash.
*/
var HASH_RE = /#/g;
var AMPERSAND_RE = /&/g;
var SLASH_RE = /\//g;
var EQUAL_RE = /=/g;
var IM_RE = /\?/g;
var PLUS_RE = /\+/g;
/**
* NOTE: It's not clear to me if we should encode the + symbol in queries, it
* seems to be less flexible than not doing so and I can't find out the legacy
* systems requiring this for regular requests like text/html. In the standard,
* the encoding of the plus character is only mentioned for
* application/x-www-form-urlencoded
* (https://url.spec.whatwg.org/#urlencoded-parsing) and most browsers seems lo
* leave the plus character as is in queries. To be more flexible, we allow the
* plus character on the query, but it can also be manually encoded by the user.
*
* Resources:
* - https://url.spec.whatwg.org/#urlencoded-parsing
* - https://stackoverflow.com/questions/1634271/url-encoding-the-space-character-or-20
*/
var ENC_BRACKET_OPEN_RE = /%5B/g;
var ENC_BRACKET_CLOSE_RE = /%5D/g;
var ENC_CARET_RE = /%5E/g;
var ENC_BACKTICK_RE = /%60/g;
var ENC_CURLY_OPEN_RE = /%7B/g;
var ENC_PIPE_RE = /%7C/g;
var ENC_CURLY_CLOSE_RE = /%7D/g;
var ENC_SPACE_RE = /%20/g;
/**
* Encode characters that need to be encoded on the path, search and hash
* sections of the URL.
*
* @internal
* @param text - string to encode
* @returns encoded string
*/
function commonEncode(text) {
	return encodeURI("" + text).replace(ENC_PIPE_RE, "|").replace(ENC_BRACKET_OPEN_RE, "[").replace(ENC_BRACKET_CLOSE_RE, "]");
}
/**
* Encode characters that need to be encoded on the hash section of the URL.
*
* @param text - string to encode
* @returns encoded string
*/
function encodeHash(text) {
	return commonEncode(text).replace(ENC_CURLY_OPEN_RE, "{").replace(ENC_CURLY_CLOSE_RE, "}").replace(ENC_CARET_RE, "^");
}
/**
* Encode characters that need to be encoded query values on the query
* section of the URL.
*
* @param text - string to encode
* @returns encoded string
*/
function encodeQueryValue(text) {
	return commonEncode(text).replace(PLUS_RE, "%2B").replace(ENC_SPACE_RE, "+").replace(HASH_RE, "%23").replace(AMPERSAND_RE, "%26").replace(ENC_BACKTICK_RE, "`").replace(ENC_CURLY_OPEN_RE, "{").replace(ENC_CURLY_CLOSE_RE, "}").replace(ENC_CARET_RE, "^");
}
/**
* Like `encodeQueryValue` but also encodes the `=` character.
*
* @param text - string to encode
*/
function encodeQueryKey(text) {
	return encodeQueryValue(text).replace(EQUAL_RE, "%3D");
}
/**
* Encode characters that need to be encoded on the path section of the URL.
*
* @param text - string to encode
* @returns encoded string
*/
function encodePath(text) {
	return commonEncode(text).replace(HASH_RE, "%23").replace(IM_RE, "%3F");
}
/**
* Encode characters that need to be encoded on the path section of the URL as a
* param. This function encodes everything {@link encodePath} does plus the
* slash (`/`) character. If `text` is `null` or `undefined`, returns an empty
* string instead.
*
* @param text - string to encode
* @returns encoded string
*/
function encodeParam(text) {
	return text == null ? "" : encodePath(text).replace(SLASH_RE, "%2F");
}
/**
* Decode text using `decodeURIComponent`. Returns the original text if it
* fails.
*
* @param text - string to decode
* @returns decoded string
*/
function decode(text) {
	try {
		return decodeURIComponent("" + text);
	} catch (err) {}
	return "" + text;
}
var TRAILING_SLASH_RE = /\/$/;
var removeTrailingSlash = (path) => path.replace(TRAILING_SLASH_RE, "");
/**
* Transforms a URI into a normalized history location
*
* @param parseQuery
* @param location - URI to normalize
* @param currentLocation - current absolute location. Allows resolving relative
* paths. Must start with `/`. Defaults to `/`
* @returns a normalized history location
*/
function parseURL(parseQuery, location, currentLocation = "/") {
	let path, query = {}, searchString = "", hash = "";
	const hashPos = location.indexOf("#");
	let searchPos = location.indexOf("?");
	if (hashPos < searchPos && hashPos >= 0) searchPos = -1;
	if (searchPos > -1) {
		path = location.slice(0, searchPos);
		searchString = location.slice(searchPos + 1, hashPos > -1 ? hashPos : location.length);
		query = parseQuery(searchString);
	}
	if (hashPos > -1) {
		path = path || location.slice(0, hashPos);
		hash = location.slice(hashPos, location.length);
	}
	path = resolveRelativePath(path != null ? path : location, currentLocation);
	return {
		fullPath: path + (searchString && "?") + searchString + hash,
		path,
		query,
		hash: decode(hash)
	};
}
/**
* Stringifies a URL object
*
* @param stringifyQuery
* @param location
*/
function stringifyURL(stringifyQuery, location) {
	const query = location.query ? stringifyQuery(location.query) : "";
	return location.path + (query && "?") + query + (location.hash || "");
}
/**
* Checks if two RouteLocation are equal. This means that both locations are
* pointing towards the same {@link RouteRecord} and that all `params`, `query`
* parameters and `hash` are the same
*
* @param stringifyQuery - A function that takes a query object of type LocationQueryRaw and returns a string representation of it.
* @param a - first {@link RouteLocation}
* @param b - second {@link RouteLocation}
*/
function isSameRouteLocation(stringifyQuery, a, b) {
	const aLastIndex = a.matched.length - 1;
	const bLastIndex = b.matched.length - 1;
	return aLastIndex > -1 && aLastIndex === bLastIndex && isSameRouteRecord(a.matched[aLastIndex], b.matched[bLastIndex]) && isSameRouteLocationParams(a.params, b.params) && stringifyQuery(a.query) === stringifyQuery(b.query) && a.hash === b.hash;
}
/**
* Check if two `RouteRecords` are equal. Takes into account aliases: they are
* considered equal to the `RouteRecord` they are aliasing.
*
* @param a - first {@link RouteRecord}
* @param b - second {@link RouteRecord}
*/
function isSameRouteRecord(a, b) {
	return (a.aliasOf || a) === (b.aliasOf || b);
}
function isSameRouteLocationParams(a, b) {
	if (Object.keys(a).length !== Object.keys(b).length) return false;
	for (const key in a) if (!isSameRouteLocationParamsValue(a[key], b[key])) return false;
	return true;
}
function isSameRouteLocationParamsValue(a, b) {
	return isArray(a) ? isEquivalentArray(a, b) : isArray(b) ? isEquivalentArray(b, a) : a === b;
}
/**
* Check if two arrays are the same or if an array with one single entry is the
* same as another primitive value. Used to check query and parameters
*
* @param a - array of values
* @param b - array of values or a single value
*/
function isEquivalentArray(a, b) {
	return isArray(b) ? a.length === b.length && a.every((value, i) => value === b[i]) : a.length === 1 && a[0] === b;
}
/**
* Resolves a relative path that starts with `.`.
*
* @param to - path location we are resolving
* @param from - currentLocation.path, should start with `/`
*/
function resolveRelativePath(to, from) {
	if (to.startsWith("/")) return to;
	if (!to) return from;
	const fromSegments = from.split("/");
	const toSegments = to.split("/");
	const lastToSegment = toSegments[toSegments.length - 1];
	if (lastToSegment === ".." || lastToSegment === ".") toSegments.push("");
	let position = fromSegments.length - 1;
	let toPosition;
	let segment;
	for (toPosition = 0; toPosition < toSegments.length; toPosition++) {
		segment = toSegments[toPosition];
		if (segment === ".") continue;
		if (segment === "..") {
			if (position > 1) position--;
		} else break;
	}
	return fromSegments.slice(0, position).join("/") + "/" + toSegments.slice(toPosition).join("/");
}
var NavigationType;
(function(NavigationType) {
	NavigationType["pop"] = "pop";
	NavigationType["push"] = "push";
})(NavigationType || (NavigationType = {}));
var NavigationDirection;
(function(NavigationDirection) {
	NavigationDirection["back"] = "back";
	NavigationDirection["forward"] = "forward";
	NavigationDirection["unknown"] = "";
})(NavigationDirection || (NavigationDirection = {}));
/**
* Starting location for Histories
*/
var START = "";
/**
* Normalizes a base by removing any trailing slash and reading the base tag if
* present.
*
* @param base - base to normalize
*/
function normalizeBase(base) {
	if (!base) if (isBrowser) {
		const baseEl = document.querySelector("base");
		base = baseEl && baseEl.getAttribute("href") || "/";
		base = base.replace(/^\w+:\/\/[^\/]+/, "");
	} else base = "/";
	if (base[0] !== "/" && base[0] !== "#") base = "/" + base;
	return removeTrailingSlash(base);
}
var BEFORE_HASH_RE = /^[^#]+#/;
function createHref(base, location) {
	return base.replace(BEFORE_HASH_RE, "#") + location;
}
function getElementPosition(el, offset) {
	const docRect = document.documentElement.getBoundingClientRect();
	const elRect = el.getBoundingClientRect();
	return {
		behavior: offset.behavior,
		left: elRect.left - docRect.left - (offset.left || 0),
		top: elRect.top - docRect.top - (offset.top || 0)
	};
}
var computeScrollPosition = () => ({
	left: window.scrollX,
	top: window.scrollY
});
function scrollToPosition(position) {
	let scrollToOptions;
	if ("el" in position) {
		const positionEl = position.el;
		const isIdSelector = typeof positionEl === "string" && positionEl.startsWith("#");
		const el = typeof positionEl === "string" ? isIdSelector ? document.getElementById(positionEl.slice(1)) : document.querySelector(positionEl) : positionEl;
		if (!el) return;
		scrollToOptions = getElementPosition(el, position);
	} else scrollToOptions = position;
	if ("scrollBehavior" in document.documentElement.style) window.scrollTo(scrollToOptions);
	else window.scrollTo(scrollToOptions.left != null ? scrollToOptions.left : window.scrollX, scrollToOptions.top != null ? scrollToOptions.top : window.scrollY);
}
function getScrollKey(path, delta) {
	return (history.state ? history.state.position - delta : -1) + path;
}
var scrollPositions = /* @__PURE__ */ new Map();
function saveScrollPosition(key, scrollPosition) {
	scrollPositions.set(key, scrollPosition);
}
function getSavedScrollPosition(key) {
	const scroll = scrollPositions.get(key);
	scrollPositions.delete(key);
	return scroll;
}
/**
* Creates an in-memory based history. The main purpose of this history is to handle SSR. It starts in a special location that is nowhere.
* It's up to the user to replace that location with the starter location by either calling `router.push` or `router.replace`.
*
* @param base - Base applied to all urls, defaults to '/'
* @returns a history object that can be passed to the router constructor
*/
function createMemoryHistory(base = "") {
	let listeners = [];
	let queue = [START];
	let position = 0;
	base = normalizeBase(base);
	function setLocation(location) {
		position++;
		if (position !== queue.length) queue.splice(position);
		queue.push(location);
	}
	function triggerListeners(to, from, { direction, delta }) {
		const info = {
			direction,
			delta,
			type: NavigationType.pop
		};
		for (const callback of listeners) callback(to, from, info);
	}
	const routerHistory = {
		location: START,
		state: {},
		base,
		createHref: createHref.bind(null, base),
		replace(to) {
			queue.splice(position--, 1);
			setLocation(to);
		},
		push(to, data) {
			setLocation(to);
		},
		listen(callback) {
			listeners.push(callback);
			return () => {
				const index = listeners.indexOf(callback);
				if (index > -1) listeners.splice(index, 1);
			};
		},
		destroy() {
			listeners = [];
			queue = [START];
			position = 0;
		},
		go(delta, shouldTrigger = true) {
			const from = this.location;
			const direction = delta < 0 ? NavigationDirection.back : NavigationDirection.forward;
			position = Math.max(0, Math.min(position + delta, queue.length - 1));
			if (shouldTrigger) triggerListeners(this.location, from, {
				direction,
				delta
			});
		}
	};
	Object.defineProperty(routerHistory, "location", {
		enumerable: true,
		get: () => queue[position]
	});
	return routerHistory;
}
function isRouteLocation(route) {
	return typeof route === "string" || route && typeof route === "object";
}
function isRouteName(name) {
	return typeof name === "string" || typeof name === "symbol";
}
/**
* Initial route location where the router is. Can be used in navigation guards
* to differentiate the initial navigation.
*
* @example
* ```js
* import { START_LOCATION } from 'vue-router'
*
* router.beforeEach((to, from) => {
*   if (from === START_LOCATION) {
*     // initial navigation
*   }
* })
* ```
*/
var START_LOCATION_NORMALIZED = {
	path: "/",
	name: void 0,
	params: {},
	query: {},
	hash: "",
	fullPath: "/",
	matched: [],
	meta: {},
	redirectedFrom: void 0
};
var NavigationFailureSymbol = Symbol("");
/**
* Enumeration with all possible types for navigation failures. Can be passed to
* {@link isNavigationFailure} to check for specific failures.
*/
var NavigationFailureType;
(function(NavigationFailureType) {
	/**
	* An aborted navigation is a navigation that failed because a navigation
	* guard returned `false` or called `next(false)`
	*/
	NavigationFailureType[NavigationFailureType["aborted"] = 4] = "aborted";
	/**
	* A cancelled navigation is a navigation that failed because a more recent
	* navigation finished started (not necessarily finished).
	*/
	NavigationFailureType[NavigationFailureType["cancelled"] = 8] = "cancelled";
	/**
	* A duplicated navigation is a navigation that failed because it was
	* initiated while already being at the exact same location.
	*/
	NavigationFailureType[NavigationFailureType["duplicated"] = 16] = "duplicated";
})(NavigationFailureType || (NavigationFailureType = {}));
/**
* Creates a typed NavigationFailure object.
* @internal
* @param type - NavigationFailureType
* @param params - { from, to }
*/
function createRouterError(type, params) {
	return assign(/* @__PURE__ */ new Error(), {
		type,
		[NavigationFailureSymbol]: true
	}, params);
}
function isNavigationFailure(error, type) {
	return error instanceof Error && NavigationFailureSymbol in error && (type == null || !!(error.type & type));
}
var BASE_PARAM_PATTERN = "[^/]+?";
var BASE_PATH_PARSER_OPTIONS = {
	sensitive: false,
	strict: false,
	start: true,
	end: true
};
var REGEX_CHARS_RE = /[.+*?^${}()[\]/\\]/g;
/**
* Creates a path parser from an array of Segments (a segment is an array of Tokens)
*
* @param segments - array of segments returned by tokenizePath
* @param extraOptions - optional options for the regexp
* @returns a PathParser
*/
function tokensToParser(segments, extraOptions) {
	const options = assign({}, BASE_PATH_PARSER_OPTIONS, extraOptions);
	const score = [];
	let pattern = options.start ? "^" : "";
	const keys = [];
	for (const segment of segments) {
		const segmentScores = segment.length ? [] : [90];
		if (options.strict && !segment.length) pattern += "/";
		for (let tokenIndex = 0; tokenIndex < segment.length; tokenIndex++) {
			const token = segment[tokenIndex];
			let subSegmentScore = 40 + (options.sensitive ? .25 : 0);
			if (token.type === 0) {
				if (!tokenIndex) pattern += "/";
				pattern += token.value.replace(REGEX_CHARS_RE, "\\$&");
				subSegmentScore += 40;
			} else if (token.type === 1) {
				const { value, repeatable, optional, regexp } = token;
				keys.push({
					name: value,
					repeatable,
					optional
				});
				const re = regexp ? regexp : BASE_PARAM_PATTERN;
				if (re !== BASE_PARAM_PATTERN) {
					subSegmentScore += 10;
					try {
						new RegExp(`(${re})`);
					} catch (err) {
						throw new Error(`Invalid custom RegExp for param "${value}" (${re}): ` + err.message);
					}
				}
				let subPattern = repeatable ? `((?:${re})(?:/(?:${re}))*)` : `(${re})`;
				if (!tokenIndex) subPattern = optional && segment.length < 2 ? `(?:/${subPattern})` : "/" + subPattern;
				if (optional) subPattern += "?";
				pattern += subPattern;
				subSegmentScore += 20;
				if (optional) subSegmentScore += -8;
				if (repeatable) subSegmentScore += -20;
				if (re === ".*") subSegmentScore += -50;
			}
			segmentScores.push(subSegmentScore);
		}
		score.push(segmentScores);
	}
	if (options.strict && options.end) {
		const i = score.length - 1;
		score[i][score[i].length - 1] += .7000000000000001;
	}
	if (!options.strict) pattern += "/?";
	if (options.end) pattern += "$";
	else if (options.strict) pattern += "(?:/|$)";
	const re = new RegExp(pattern, options.sensitive ? "" : "i");
	function parse(path) {
		const match = path.match(re);
		const params = {};
		if (!match) return null;
		for (let i = 1; i < match.length; i++) {
			const value = match[i] || "";
			const key = keys[i - 1];
			params[key.name] = value && key.repeatable ? value.split("/") : value;
		}
		return params;
	}
	function stringify(params) {
		let path = "";
		let avoidDuplicatedSlash = false;
		for (const segment of segments) {
			if (!avoidDuplicatedSlash || !path.endsWith("/")) path += "/";
			avoidDuplicatedSlash = false;
			for (const token of segment) if (token.type === 0) path += token.value;
			else if (token.type === 1) {
				const { value, repeatable, optional } = token;
				const param = value in params ? params[value] : "";
				if (isArray(param) && !repeatable) throw new Error(`Provided param "${value}" is an array but it is not repeatable (* or + modifiers)`);
				const text = isArray(param) ? param.join("/") : param;
				if (!text) if (optional) {
					if (segment.length < 2) if (path.endsWith("/")) path = path.slice(0, -1);
					else avoidDuplicatedSlash = true;
				} else throw new Error(`Missing required param "${value}"`);
				path += text;
			}
		}
		return path || "/";
	}
	return {
		re,
		score,
		keys,
		parse,
		stringify
	};
}
/**
* Compares an array of numbers as used in PathParser.score and returns a
* number. This function can be used to `sort` an array
*
* @param a - first array of numbers
* @param b - second array of numbers
* @returns 0 if both are equal, < 0 if a should be sorted first, > 0 if b
* should be sorted first
*/
function compareScoreArray(a, b) {
	let i = 0;
	while (i < a.length && i < b.length) {
		const diff = b[i] - a[i];
		if (diff) return diff;
		i++;
	}
	if (a.length < b.length) return a.length === 1 && a[0] === 80 ? -1 : 1;
	else if (a.length > b.length) return b.length === 1 && b[0] === 80 ? 1 : -1;
	return 0;
}
/**
* Compare function that can be used with `sort` to sort an array of PathParser
*
* @param a - first PathParser
* @param b - second PathParser
* @returns 0 if both are equal, < 0 if a should be sorted first, > 0 if b
*/
function comparePathParserScore(a, b) {
	let i = 0;
	const aScore = a.score;
	const bScore = b.score;
	while (i < aScore.length && i < bScore.length) {
		const comp = compareScoreArray(aScore[i], bScore[i]);
		if (comp) return comp;
		i++;
	}
	if (Math.abs(bScore.length - aScore.length) === 1) {
		if (isLastScoreNegative(aScore)) return 1;
		if (isLastScoreNegative(bScore)) return -1;
	}
	return bScore.length - aScore.length;
}
/**
* This allows detecting splats at the end of a path: /home/:id(.*)*
*
* @param score - score to check
* @returns true if the last entry is negative
*/
function isLastScoreNegative(score) {
	const last = score[score.length - 1];
	return score.length > 0 && last[last.length - 1] < 0;
}
var ROOT_TOKEN = {
	type: 0,
	value: ""
};
var VALID_PARAM_RE = /[a-zA-Z0-9_]/;
function tokenizePath(path) {
	if (!path) return [[]];
	if (path === "/") return [[ROOT_TOKEN]];
	if (!path.startsWith("/")) throw new Error(`Invalid path "${path}"`);
	function crash(message) {
		throw new Error(`ERR (${state})/"${buffer}": ${message}`);
	}
	let state = 0;
	let previousState = state;
	const tokens = [];
	let segment;
	function finalizeSegment() {
		if (segment) tokens.push(segment);
		segment = [];
	}
	let i = 0;
	let char;
	let buffer = "";
	let customRe = "";
	function consumeBuffer() {
		if (!buffer) return;
		if (state === 0) segment.push({
			type: 0,
			value: buffer
		});
		else if (state === 1 || state === 2 || state === 3) {
			if (segment.length > 1 && (char === "*" || char === "+")) crash(`A repeatable param (${buffer}) must be alone in its segment. eg: '/:ids+.`);
			segment.push({
				type: 1,
				value: buffer,
				regexp: customRe,
				repeatable: char === "*" || char === "+",
				optional: char === "*" || char === "?"
			});
		} else crash("Invalid state to consume buffer");
		buffer = "";
	}
	function addCharToBuffer() {
		buffer += char;
	}
	while (i < path.length) {
		char = path[i++];
		if (char === "\\" && state !== 2) {
			previousState = state;
			state = 4;
			continue;
		}
		switch (state) {
			case 0:
				if (char === "/") {
					if (buffer) consumeBuffer();
					finalizeSegment();
				} else if (char === ":") {
					consumeBuffer();
					state = 1;
				} else addCharToBuffer();
				break;
			case 4:
				addCharToBuffer();
				state = previousState;
				break;
			case 1:
				if (char === "(") state = 2;
				else if (VALID_PARAM_RE.test(char)) addCharToBuffer();
				else {
					consumeBuffer();
					state = 0;
					if (char !== "*" && char !== "?" && char !== "+") i--;
				}
				break;
			case 2:
				if (char === ")") if (customRe[customRe.length - 1] == "\\") customRe = customRe.slice(0, -1) + char;
				else state = 3;
				else customRe += char;
				break;
			case 3:
				consumeBuffer();
				state = 0;
				if (char !== "*" && char !== "?" && char !== "+") i--;
				customRe = "";
				break;
			default:
				crash("Unknown state");
				break;
		}
	}
	if (state === 2) crash(`Unfinished custom RegExp for param "${buffer}"`);
	consumeBuffer();
	finalizeSegment();
	return tokens;
}
function createRouteRecordMatcher(record, parent, options) {
	const matcher = assign(tokensToParser(tokenizePath(record.path), options), {
		record,
		parent,
		children: [],
		alias: []
	});
	if (parent) {
		if (!matcher.record.aliasOf === !parent.record.aliasOf) parent.children.push(matcher);
	}
	return matcher;
}
/**
* Creates a Router Matcher.
*
* @internal
* @param routes - array of initial routes
* @param globalOptions - global route options
*/
function createRouterMatcher(routes, globalOptions) {
	const matchers = [];
	const matcherMap = /* @__PURE__ */ new Map();
	globalOptions = mergeOptions({
		strict: false,
		end: true,
		sensitive: false
	}, globalOptions);
	function getRecordMatcher(name) {
		return matcherMap.get(name);
	}
	function addRoute(record, parent, originalRecord) {
		const isRootAdd = !originalRecord;
		const mainNormalizedRecord = normalizeRouteRecord(record);
		mainNormalizedRecord.aliasOf = originalRecord && originalRecord.record;
		const options = mergeOptions(globalOptions, record);
		const normalizedRecords = [mainNormalizedRecord];
		if ("alias" in record) {
			const aliases = typeof record.alias === "string" ? [record.alias] : record.alias;
			for (const alias of aliases) normalizedRecords.push(assign({}, mainNormalizedRecord, {
				components: originalRecord ? originalRecord.record.components : mainNormalizedRecord.components,
				path: alias,
				aliasOf: originalRecord ? originalRecord.record : mainNormalizedRecord
			}));
		}
		let matcher;
		let originalMatcher;
		for (const normalizedRecord of normalizedRecords) {
			const { path } = normalizedRecord;
			if (parent && path[0] !== "/") {
				const parentPath = parent.record.path;
				const connectingSlash = parentPath[parentPath.length - 1] === "/" ? "" : "/";
				normalizedRecord.path = parent.record.path + (path && connectingSlash + path);
			}
			matcher = createRouteRecordMatcher(normalizedRecord, parent, options);
			if (originalRecord) originalRecord.alias.push(matcher);
			else {
				originalMatcher = originalMatcher || matcher;
				if (originalMatcher !== matcher) originalMatcher.alias.push(matcher);
				if (isRootAdd && record.name && !isAliasRecord(matcher)) removeRoute(record.name);
			}
			if (isMatchable(matcher)) insertMatcher(matcher);
			if (mainNormalizedRecord.children) {
				const children = mainNormalizedRecord.children;
				for (let i = 0; i < children.length; i++) addRoute(children[i], matcher, originalRecord && originalRecord.children[i]);
			}
			originalRecord = originalRecord || matcher;
		}
		return originalMatcher ? () => {
			removeRoute(originalMatcher);
		} : noop;
	}
	function removeRoute(matcherRef) {
		if (isRouteName(matcherRef)) {
			const matcher = matcherMap.get(matcherRef);
			if (matcher) {
				matcherMap.delete(matcherRef);
				matchers.splice(matchers.indexOf(matcher), 1);
				matcher.children.forEach(removeRoute);
				matcher.alias.forEach(removeRoute);
			}
		} else {
			const index = matchers.indexOf(matcherRef);
			if (index > -1) {
				matchers.splice(index, 1);
				if (matcherRef.record.name) matcherMap.delete(matcherRef.record.name);
				matcherRef.children.forEach(removeRoute);
				matcherRef.alias.forEach(removeRoute);
			}
		}
	}
	function getRoutes() {
		return matchers;
	}
	function insertMatcher(matcher) {
		const index = findInsertionIndex(matcher, matchers);
		matchers.splice(index, 0, matcher);
		if (matcher.record.name && !isAliasRecord(matcher)) matcherMap.set(matcher.record.name, matcher);
	}
	function resolve(location, currentLocation) {
		let matcher;
		let params = {};
		let path;
		let name;
		if ("name" in location && location.name) {
			matcher = matcherMap.get(location.name);
			if (!matcher) throw createRouterError(1, { location });
			name = matcher.record.name;
			params = assign(paramsFromLocation(currentLocation.params, matcher.keys.filter((k) => !k.optional).concat(matcher.parent ? matcher.parent.keys.filter((k) => k.optional) : []).map((k) => k.name)), location.params && paramsFromLocation(location.params, matcher.keys.map((k) => k.name)));
			path = matcher.stringify(params);
		} else if (location.path != null) {
			path = location.path;
			matcher = matchers.find((m) => m.re.test(path));
			if (matcher) {
				params = matcher.parse(path);
				name = matcher.record.name;
			}
		} else {
			matcher = currentLocation.name ? matcherMap.get(currentLocation.name) : matchers.find((m) => m.re.test(currentLocation.path));
			if (!matcher) throw createRouterError(1, {
				location,
				currentLocation
			});
			name = matcher.record.name;
			params = assign({}, currentLocation.params, location.params);
			path = matcher.stringify(params);
		}
		const matched = [];
		let parentMatcher = matcher;
		while (parentMatcher) {
			matched.unshift(parentMatcher.record);
			parentMatcher = parentMatcher.parent;
		}
		return {
			name,
			path,
			params,
			matched,
			meta: mergeMetaFields(matched)
		};
	}
	routes.forEach((route) => addRoute(route));
	return {
		addRoute,
		resolve,
		removeRoute,
		getRoutes,
		getRecordMatcher
	};
}
function paramsFromLocation(params, keys) {
	const newParams = {};
	for (const key of keys) if (key in params) newParams[key] = params[key];
	return newParams;
}
/**
* Normalizes a RouteRecordRaw. Creates a copy
*
* @param record
* @returns the normalized version
*/
function normalizeRouteRecord(record) {
	return {
		path: record.path,
		redirect: record.redirect,
		name: record.name,
		meta: record.meta || {},
		aliasOf: void 0,
		beforeEnter: record.beforeEnter,
		props: normalizeRecordProps(record),
		children: record.children || [],
		instances: {},
		leaveGuards: /* @__PURE__ */ new Set(),
		updateGuards: /* @__PURE__ */ new Set(),
		enterCallbacks: {},
		components: "components" in record ? record.components || null : record.component && { default: record.component }
	};
}
/**
* Normalize the optional `props` in a record to always be an object similar to
* components. Also accept a boolean for components.
* @param record
*/
function normalizeRecordProps(record) {
	const propsObject = {};
	const props = record.props || false;
	if ("component" in record) propsObject.default = props;
	else for (const name in record.components) propsObject[name] = typeof props === "object" ? props[name] : props;
	return propsObject;
}
/**
* Checks if a record or any of its parent is an alias
* @param record
*/
function isAliasRecord(record) {
	while (record) {
		if (record.record.aliasOf) return true;
		record = record.parent;
	}
	return false;
}
/**
* Merge meta fields of an array of records
*
* @param matched - array of matched records
*/
function mergeMetaFields(matched) {
	return matched.reduce((meta, record) => assign(meta, record.meta), {});
}
function mergeOptions(defaults, partialOptions) {
	const options = {};
	for (const key in defaults) options[key] = key in partialOptions ? partialOptions[key] : defaults[key];
	return options;
}
/**
* Performs a binary search to find the correct insertion index for a new matcher.
*
* Matchers are primarily sorted by their score. If scores are tied then we also consider parent/child relationships,
* with descendants coming before ancestors. If there's still a tie, new routes are inserted after existing routes.
*
* @param matcher - new matcher to be inserted
* @param matchers - existing matchers
*/
function findInsertionIndex(matcher, matchers) {
	let lower = 0;
	let upper = matchers.length;
	while (lower !== upper) {
		const mid = lower + upper >> 1;
		if (comparePathParserScore(matcher, matchers[mid]) < 0) upper = mid;
		else lower = mid + 1;
	}
	const insertionAncestor = getInsertionAncestor(matcher);
	if (insertionAncestor) upper = matchers.lastIndexOf(insertionAncestor, upper - 1);
	return upper;
}
function getInsertionAncestor(matcher) {
	let ancestor = matcher;
	while (ancestor = ancestor.parent) if (isMatchable(ancestor) && comparePathParserScore(matcher, ancestor) === 0) return ancestor;
}
/**
* Checks if a matcher can be reachable. This means if it's possible to reach it as a route. For example, routes without
* a component, or name, or redirect, are just used to group other routes.
* @param matcher
* @param matcher.record record of the matcher
* @returns
*/
function isMatchable({ record }) {
	return !!(record.name || record.components && Object.keys(record.components).length || record.redirect);
}
/**
* Transforms a queryString into a {@link LocationQuery} object. Accept both, a
* version with the leading `?` and without Should work as URLSearchParams

* @internal
*
* @param search - search string to parse
* @returns a query object
*/
function parseQuery(search) {
	const query = {};
	if (search === "" || search === "?") return query;
	const searchParams = (search[0] === "?" ? search.slice(1) : search).split("&");
	for (let i = 0; i < searchParams.length; ++i) {
		const searchParam = searchParams[i].replace(PLUS_RE, " ");
		const eqPos = searchParam.indexOf("=");
		const key = decode(eqPos < 0 ? searchParam : searchParam.slice(0, eqPos));
		const value = eqPos < 0 ? null : decode(searchParam.slice(eqPos + 1));
		if (key in query) {
			let currentValue = query[key];
			if (!isArray(currentValue)) currentValue = query[key] = [currentValue];
			currentValue.push(value);
		} else query[key] = value;
	}
	return query;
}
/**
* Stringifies a {@link LocationQueryRaw} object. Like `URLSearchParams`, it
* doesn't prepend a `?`
*
* @internal
*
* @param query - query object to stringify
* @returns string version of the query without the leading `?`
*/
function stringifyQuery(query) {
	let search = "";
	for (let key in query) {
		const value = query[key];
		key = encodeQueryKey(key);
		if (value == null) {
			if (value !== void 0) search += (search.length ? "&" : "") + key;
			continue;
		}
		(isArray(value) ? value.map((v) => v && encodeQueryValue(v)) : [value && encodeQueryValue(value)]).forEach((value) => {
			if (value !== void 0) {
				search += (search.length ? "&" : "") + key;
				if (value != null) search += "=" + value;
			}
		});
	}
	return search;
}
/**
* Transforms a {@link LocationQueryRaw} into a {@link LocationQuery} by casting
* numbers into strings, removing keys with an undefined value and replacing
* undefined with null in arrays
*
* @param query - query object to normalize
* @returns a normalized query object
*/
function normalizeQuery(query) {
	const normalizedQuery = {};
	for (const key in query) {
		const value = query[key];
		if (value !== void 0) normalizedQuery[key] = isArray(value) ? value.map((v) => v == null ? null : "" + v) : value == null ? value : "" + value;
	}
	return normalizedQuery;
}
/**
* RouteRecord being rendered by the closest ancestor Router View. Used for
* `onBeforeRouteUpdate` and `onBeforeRouteLeave`. rvlm stands for Router View
* Location Matched
*
* @internal
*/
var matchedRouteKey = Symbol("");
/**
* Allows overriding the router view depth to control which component in
* `matched` is rendered. rvd stands for Router View Depth
*
* @internal
*/
var viewDepthKey = Symbol("");
/**
* Allows overriding the router instance returned by `useRouter` in tests. r
* stands for router
*
* @internal
*/
var routerKey = Symbol("");
/**
* Allows overriding the current route returned by `useRoute` in tests. rl
* stands for route location
*
* @internal
*/
var routeLocationKey = Symbol("");
/**
* Allows overriding the current route used by router-view. Internally this is
* used when the `route` prop is passed.
*
* @internal
*/
var routerViewLocationKey = Symbol("");
/**
* Create a list of callbacks that can be reset. Used to create before and after navigation guards list
*/
function useCallbacks() {
	let handlers = [];
	function add(handler) {
		handlers.push(handler);
		return () => {
			const i = handlers.indexOf(handler);
			if (i > -1) handlers.splice(i, 1);
		};
	}
	function reset() {
		handlers = [];
	}
	return {
		add,
		list: () => handlers.slice(),
		reset
	};
}
function guardToPromiseFn(guard, to, from, record, name, runWithContext = (fn) => fn()) {
	const enterCallbackArray = record && (record.enterCallbacks[name] = record.enterCallbacks[name] || []);
	return () => new Promise((resolve, reject) => {
		const next = (valid) => {
			if (valid === false) reject(createRouterError(4, {
				from,
				to
			}));
			else if (valid instanceof Error) reject(valid);
			else if (isRouteLocation(valid)) reject(createRouterError(2, {
				from: to,
				to: valid
			}));
			else {
				if (enterCallbackArray && record.enterCallbacks[name] === enterCallbackArray && typeof valid === "function") enterCallbackArray.push(valid);
				resolve();
			}
		};
		const guardReturn = runWithContext(() => guard.call(record && record.instances[name], to, from, next));
		let guardCall = Promise.resolve(guardReturn);
		if (guard.length < 3) guardCall = guardCall.then(next);
		guardCall.catch((err) => reject(err));
	});
}
function extractComponentsGuards(matched, guardType, to, from, runWithContext = (fn) => fn()) {
	const guards = [];
	for (const record of matched) for (const name in record.components) {
		let rawComponent = record.components[name];
		if (guardType !== "beforeRouteEnter" && !record.instances[name]) continue;
		if (isRouteComponent(rawComponent)) {
			const guard = (rawComponent.__vccOpts || rawComponent)[guardType];
			guard && guards.push(guardToPromiseFn(guard, to, from, record, name, runWithContext));
		} else {
			let componentPromise = rawComponent();
			guards.push(() => componentPromise.then((resolved) => {
				if (!resolved) return Promise.reject(/* @__PURE__ */ new Error(`Couldn't resolve component "${name}" at "${record.path}"`));
				const resolvedComponent = isESModule(resolved) ? resolved.default : resolved;
				record.components[name] = resolvedComponent;
				const guard = (resolvedComponent.__vccOpts || resolvedComponent)[guardType];
				return guard && guardToPromiseFn(guard, to, from, record, name, runWithContext)();
			}));
		}
	}
	return guards;
}
/**
* Allows differentiating lazy components from functional components and vue-class-component
* @internal
*
* @param component
*/
function isRouteComponent(component) {
	return typeof component === "object" || "displayName" in component || "props" in component || "__vccOpts" in component;
}
function useLink(props) {
	const router = inject(routerKey);
	const currentRoute = inject(routeLocationKey);
	const route = computed(() => {
		const to = unref(props.to);
		return router.resolve(to);
	});
	const activeRecordIndex = computed(() => {
		const { matched } = route.value;
		const { length } = matched;
		const routeMatched = matched[length - 1];
		const currentMatched = currentRoute.matched;
		if (!routeMatched || !currentMatched.length) return -1;
		const index = currentMatched.findIndex(isSameRouteRecord.bind(null, routeMatched));
		if (index > -1) return index;
		const parentRecordPath = getOriginalPath(matched[length - 2]);
		return length > 1 && getOriginalPath(routeMatched) === parentRecordPath && currentMatched[currentMatched.length - 1].path !== parentRecordPath ? currentMatched.findIndex(isSameRouteRecord.bind(null, matched[length - 2])) : index;
	});
	const isActive = computed(() => activeRecordIndex.value > -1 && includesParams(currentRoute.params, route.value.params));
	const isExactActive = computed(() => activeRecordIndex.value > -1 && activeRecordIndex.value === currentRoute.matched.length - 1 && isSameRouteLocationParams(currentRoute.params, route.value.params));
	function navigate(e = {}) {
		if (guardEvent(e)) return router[unref(props.replace) ? "replace" : "push"](unref(props.to)).catch(noop);
		return Promise.resolve();
	}
	/**
	* NOTE: update {@link _RouterLinkI}'s `$slots` type when updating this
	*/
	return {
		route,
		href: computed(() => route.value.href),
		isActive,
		isExactActive,
		navigate
	};
}
/**
* Component to render a link that triggers a navigation on click.
*/
var RouterLink = /* @__PURE__ */ defineComponent({
	name: "RouterLink",
	compatConfig: { MODE: 3 },
	props: {
		to: {
			type: [String, Object],
			required: true
		},
		replace: Boolean,
		activeClass: String,
		exactActiveClass: String,
		custom: Boolean,
		ariaCurrentValue: {
			type: String,
			default: "page"
		}
	},
	useLink,
	setup(props, { slots }) {
		const link = reactive(useLink(props));
		const { options } = inject(routerKey);
		const elClass = computed(() => ({
			[getLinkClass(props.activeClass, options.linkActiveClass, "router-link-active")]: link.isActive,
			[getLinkClass(props.exactActiveClass, options.linkExactActiveClass, "router-link-exact-active")]: link.isExactActive
		}));
		return () => {
			const children = slots.default && slots.default(link);
			return props.custom ? children : h("a", {
				"aria-current": link.isExactActive ? props.ariaCurrentValue : null,
				href: link.href,
				onClick: link.navigate,
				class: elClass.value
			}, children);
		};
	}
});
function guardEvent(e) {
	if (e.metaKey || e.altKey || e.ctrlKey || e.shiftKey) return;
	if (e.defaultPrevented) return;
	if (e.button !== void 0 && e.button !== 0) return;
	if (e.currentTarget && e.currentTarget.getAttribute) {
		const target = e.currentTarget.getAttribute("target");
		if (/\b_blank\b/i.test(target)) return;
	}
	if (e.preventDefault) e.preventDefault();
	return true;
}
function includesParams(outer, inner) {
	for (const key in inner) {
		const innerValue = inner[key];
		const outerValue = outer[key];
		if (typeof innerValue === "string") {
			if (innerValue !== outerValue) return false;
		} else if (!isArray(outerValue) || outerValue.length !== innerValue.length || innerValue.some((value, i) => value !== outerValue[i])) return false;
	}
	return true;
}
/**
* Get the original path value of a record by following its aliasOf
* @param record
*/
function getOriginalPath(record) {
	return record ? record.aliasOf ? record.aliasOf.path : record.path : "";
}
/**
* Utility class to get the active class based on defaults.
* @param propClass
* @param globalClass
* @param defaultClass
*/
var getLinkClass = (propClass, globalClass, defaultClass) => propClass != null ? propClass : globalClass != null ? globalClass : defaultClass;
var RouterViewImpl = /* @__PURE__ */ defineComponent({
	name: "RouterView",
	inheritAttrs: false,
	props: {
		name: {
			type: String,
			default: "default"
		},
		route: Object
	},
	compatConfig: { MODE: 3 },
	setup(props, { attrs, slots }) {
		const injectedRoute = inject(routerViewLocationKey);
		const routeToDisplay = computed(() => props.route || injectedRoute.value);
		const injectedDepth = inject(viewDepthKey, 0);
		const depth = computed(() => {
			let initialDepth = unref(injectedDepth);
			const { matched } = routeToDisplay.value;
			let matchedRoute;
			while ((matchedRoute = matched[initialDepth]) && !matchedRoute.components) initialDepth++;
			return initialDepth;
		});
		const matchedRouteRef = computed(() => routeToDisplay.value.matched[depth.value]);
		provide(viewDepthKey, computed(() => depth.value + 1));
		provide(matchedRouteKey, matchedRouteRef);
		provide(routerViewLocationKey, routeToDisplay);
		const viewRef = ref();
		watch(() => [
			viewRef.value,
			matchedRouteRef.value,
			props.name
		], ([instance, to, name], [oldInstance, from, oldName]) => {
			if (to) {
				to.instances[name] = instance;
				if (from && from !== to && instance && instance === oldInstance) {
					if (!to.leaveGuards.size) to.leaveGuards = from.leaveGuards;
					if (!to.updateGuards.size) to.updateGuards = from.updateGuards;
				}
			}
			if (instance && to && (!from || !isSameRouteRecord(to, from) || !oldInstance)) (to.enterCallbacks[name] || []).forEach((callback) => callback(instance));
		}, { flush: "post" });
		return () => {
			const route = routeToDisplay.value;
			const currentName = props.name;
			const matchedRoute = matchedRouteRef.value;
			const ViewComponent = matchedRoute && matchedRoute.components[currentName];
			if (!ViewComponent) return normalizeSlot(slots.default, {
				Component: ViewComponent,
				route
			});
			const routePropsOption = matchedRoute.props[currentName];
			const routeProps = routePropsOption ? routePropsOption === true ? route.params : typeof routePropsOption === "function" ? routePropsOption(route) : routePropsOption : null;
			const onVnodeUnmounted = (vnode) => {
				if (vnode.component.isUnmounted) matchedRoute.instances[currentName] = null;
			};
			const component = h(ViewComponent, assign({}, routeProps, attrs, {
				onVnodeUnmounted,
				ref: viewRef
			}));
			return normalizeSlot(slots.default, {
				Component: component,
				route
			}) || component;
		};
	}
});
function normalizeSlot(slot, data) {
	if (!slot) return null;
	const slotContent = slot(data);
	return slotContent.length === 1 ? slotContent[0] : slotContent;
}
/**
* Component to display the current route the user is at.
*/
var RouterView = RouterViewImpl;
/**
* Creates a Router instance that can be used by a Vue app.
*
* @param options - {@link RouterOptions}
*/
function createRouter(options) {
	const matcher = createRouterMatcher(options.routes, options);
	const parseQuery$1 = options.parseQuery || parseQuery;
	const stringifyQuery$1 = options.stringifyQuery || stringifyQuery;
	const routerHistory = options.history;
	const beforeGuards = useCallbacks();
	const beforeResolveGuards = useCallbacks();
	const afterGuards = useCallbacks();
	const currentRoute = shallowRef(START_LOCATION_NORMALIZED);
	let pendingLocation = START_LOCATION_NORMALIZED;
	if (isBrowser && options.scrollBehavior && "scrollRestoration" in history) history.scrollRestoration = "manual";
	const normalizeParams = applyToParams.bind(null, (paramValue) => "" + paramValue);
	const encodeParams = applyToParams.bind(null, encodeParam);
	const decodeParams = applyToParams.bind(null, decode);
	function addRoute(parentOrRoute, route) {
		let parent;
		let record;
		if (isRouteName(parentOrRoute)) {
			parent = matcher.getRecordMatcher(parentOrRoute);
			record = route;
		} else record = parentOrRoute;
		return matcher.addRoute(record, parent);
	}
	function removeRoute(name) {
		const recordMatcher = matcher.getRecordMatcher(name);
		if (recordMatcher) matcher.removeRoute(recordMatcher);
	}
	function getRoutes() {
		return matcher.getRoutes().map((routeMatcher) => routeMatcher.record);
	}
	function hasRoute(name) {
		return !!matcher.getRecordMatcher(name);
	}
	function resolve(rawLocation, currentLocation) {
		currentLocation = assign({}, currentLocation || currentRoute.value);
		if (typeof rawLocation === "string") {
			const locationNormalized = parseURL(parseQuery$1, rawLocation, currentLocation.path);
			const matchedRoute = matcher.resolve({ path: locationNormalized.path }, currentLocation);
			const href = routerHistory.createHref(locationNormalized.fullPath);
			return assign(locationNormalized, matchedRoute, {
				params: decodeParams(matchedRoute.params),
				hash: decode(locationNormalized.hash),
				redirectedFrom: void 0,
				href
			});
		}
		let matcherLocation;
		if (rawLocation.path != null) matcherLocation = assign({}, rawLocation, { path: parseURL(parseQuery$1, rawLocation.path, currentLocation.path).path });
		else {
			const targetParams = assign({}, rawLocation.params);
			for (const key in targetParams) if (targetParams[key] == null) delete targetParams[key];
			matcherLocation = assign({}, rawLocation, { params: encodeParams(targetParams) });
			currentLocation.params = encodeParams(currentLocation.params);
		}
		const matchedRoute = matcher.resolve(matcherLocation, currentLocation);
		const hash = rawLocation.hash || "";
		matchedRoute.params = normalizeParams(decodeParams(matchedRoute.params));
		const fullPath = stringifyURL(stringifyQuery$1, assign({}, rawLocation, {
			hash: encodeHash(hash),
			path: matchedRoute.path
		}));
		const href = routerHistory.createHref(fullPath);
		return assign({
			fullPath,
			hash,
			query: stringifyQuery$1 === stringifyQuery ? normalizeQuery(rawLocation.query) : rawLocation.query || {}
		}, matchedRoute, {
			redirectedFrom: void 0,
			href
		});
	}
	function locationAsObject(to) {
		return typeof to === "string" ? parseURL(parseQuery$1, to, currentRoute.value.path) : assign({}, to);
	}
	function checkCanceledNavigation(to, from) {
		if (pendingLocation !== to) return createRouterError(8, {
			from,
			to
		});
	}
	function push(to) {
		return pushWithRedirect(to);
	}
	function replace(to) {
		return push(assign(locationAsObject(to), { replace: true }));
	}
	function handleRedirectRecord(to) {
		const lastMatched = to.matched[to.matched.length - 1];
		if (lastMatched && lastMatched.redirect) {
			const { redirect } = lastMatched;
			let newTargetLocation = typeof redirect === "function" ? redirect(to) : redirect;
			if (typeof newTargetLocation === "string") {
				newTargetLocation = newTargetLocation.includes("?") || newTargetLocation.includes("#") ? newTargetLocation = locationAsObject(newTargetLocation) : { path: newTargetLocation };
				newTargetLocation.params = {};
			}
			return assign({
				query: to.query,
				hash: to.hash,
				params: newTargetLocation.path != null ? {} : to.params
			}, newTargetLocation);
		}
	}
	function pushWithRedirect(to, redirectedFrom) {
		const targetLocation = pendingLocation = resolve(to);
		const from = currentRoute.value;
		const data = to.state;
		const force = to.force;
		const replace = to.replace === true;
		const shouldRedirect = handleRedirectRecord(targetLocation);
		if (shouldRedirect) return pushWithRedirect(assign(locationAsObject(shouldRedirect), {
			state: typeof shouldRedirect === "object" ? assign({}, data, shouldRedirect.state) : data,
			force,
			replace
		}), redirectedFrom || targetLocation);
		const toLocation = targetLocation;
		toLocation.redirectedFrom = redirectedFrom;
		let failure;
		if (!force && isSameRouteLocation(stringifyQuery$1, from, targetLocation)) {
			failure = createRouterError(16, {
				to: toLocation,
				from
			});
			handleScroll(from, from, true, false);
		}
		return (failure ? Promise.resolve(failure) : navigate(toLocation, from)).catch((error) => isNavigationFailure(error) ? isNavigationFailure(error, 2) ? error : markAsReady(error) : triggerError(error, toLocation, from)).then((failure) => {
			if (failure) {
				if (isNavigationFailure(failure, 2)) return pushWithRedirect(assign({ replace }, locationAsObject(failure.to), {
					state: typeof failure.to === "object" ? assign({}, data, failure.to.state) : data,
					force
				}), redirectedFrom || toLocation);
			} else failure = finalizeNavigation(toLocation, from, true, replace, data);
			triggerAfterEach(toLocation, from, failure);
			return failure;
		});
	}
	/**
	* Helper to reject and skip all navigation guards if a new navigation happened
	* @param to
	* @param from
	*/
	function checkCanceledNavigationAndReject(to, from) {
		const error = checkCanceledNavigation(to, from);
		return error ? Promise.reject(error) : Promise.resolve();
	}
	function runWithContext(fn) {
		const app = installedApps.values().next().value;
		return app && typeof app.runWithContext === "function" ? app.runWithContext(fn) : fn();
	}
	function navigate(to, from) {
		let guards;
		const [leavingRecords, updatingRecords, enteringRecords] = extractChangingRecords(to, from);
		guards = extractComponentsGuards(leavingRecords.reverse(), "beforeRouteLeave", to, from);
		for (const record of leavingRecords) record.leaveGuards.forEach((guard) => {
			guards.push(guardToPromiseFn(guard, to, from));
		});
		const canceledNavigationCheck = checkCanceledNavigationAndReject.bind(null, to, from);
		guards.push(canceledNavigationCheck);
		return runGuardQueue(guards).then(() => {
			guards = [];
			for (const guard of beforeGuards.list()) guards.push(guardToPromiseFn(guard, to, from));
			guards.push(canceledNavigationCheck);
			return runGuardQueue(guards);
		}).then(() => {
			guards = extractComponentsGuards(updatingRecords, "beforeRouteUpdate", to, from);
			for (const record of updatingRecords) record.updateGuards.forEach((guard) => {
				guards.push(guardToPromiseFn(guard, to, from));
			});
			guards.push(canceledNavigationCheck);
			return runGuardQueue(guards);
		}).then(() => {
			guards = [];
			for (const record of enteringRecords) if (record.beforeEnter) if (isArray(record.beforeEnter)) for (const beforeEnter of record.beforeEnter) guards.push(guardToPromiseFn(beforeEnter, to, from));
			else guards.push(guardToPromiseFn(record.beforeEnter, to, from));
			guards.push(canceledNavigationCheck);
			return runGuardQueue(guards);
		}).then(() => {
			to.matched.forEach((record) => record.enterCallbacks = {});
			guards = extractComponentsGuards(enteringRecords, "beforeRouteEnter", to, from, runWithContext);
			guards.push(canceledNavigationCheck);
			return runGuardQueue(guards);
		}).then(() => {
			guards = [];
			for (const guard of beforeResolveGuards.list()) guards.push(guardToPromiseFn(guard, to, from));
			guards.push(canceledNavigationCheck);
			return runGuardQueue(guards);
		}).catch((err) => isNavigationFailure(err, 8) ? err : Promise.reject(err));
	}
	function triggerAfterEach(to, from, failure) {
		afterGuards.list().forEach((guard) => runWithContext(() => guard(to, from, failure)));
	}
	/**
	* - Cleans up any navigation guards
	* - Changes the url if necessary
	* - Calls the scrollBehavior
	*/
	function finalizeNavigation(toLocation, from, isPush, replace, data) {
		const error = checkCanceledNavigation(toLocation, from);
		if (error) return error;
		const isFirstNavigation = from === START_LOCATION_NORMALIZED;
		const state = !isBrowser ? {} : history.state;
		if (isPush) if (replace || isFirstNavigation) routerHistory.replace(toLocation.fullPath, assign({ scroll: isFirstNavigation && state && state.scroll }, data));
		else routerHistory.push(toLocation.fullPath, data);
		currentRoute.value = toLocation;
		handleScroll(toLocation, from, isPush, isFirstNavigation);
		markAsReady();
	}
	let removeHistoryListener;
	function setupListeners() {
		if (removeHistoryListener) return;
		removeHistoryListener = routerHistory.listen((to, _from, info) => {
			if (!router.listening) return;
			const toLocation = resolve(to);
			const shouldRedirect = handleRedirectRecord(toLocation);
			if (shouldRedirect) {
				pushWithRedirect(assign(shouldRedirect, { replace: true }), toLocation).catch(noop);
				return;
			}
			pendingLocation = toLocation;
			const from = currentRoute.value;
			if (isBrowser) saveScrollPosition(getScrollKey(from.fullPath, info.delta), computeScrollPosition());
			navigate(toLocation, from).catch((error) => {
				if (isNavigationFailure(error, 12)) return error;
				if (isNavigationFailure(error, 2)) {
					pushWithRedirect(error.to, toLocation).then((failure) => {
						if (isNavigationFailure(failure, 20) && !info.delta && info.type === NavigationType.pop) routerHistory.go(-1, false);
					}).catch(noop);
					return Promise.reject();
				}
				if (info.delta) routerHistory.go(-info.delta, false);
				return triggerError(error, toLocation, from);
			}).then((failure) => {
				failure = failure || finalizeNavigation(toLocation, from, false);
				if (failure) {
					if (info.delta && !isNavigationFailure(failure, 8)) routerHistory.go(-info.delta, false);
					else if (info.type === NavigationType.pop && isNavigationFailure(failure, 20)) routerHistory.go(-1, false);
				}
				triggerAfterEach(toLocation, from, failure);
			}).catch(noop);
		});
	}
	let readyHandlers = useCallbacks();
	let errorListeners = useCallbacks();
	let ready;
	/**
	* Trigger errorListeners added via onError and throws the error as well
	*
	* @param error - error to throw
	* @param to - location we were navigating to when the error happened
	* @param from - location we were navigating from when the error happened
	* @returns the error as a rejected promise
	*/
	function triggerError(error, to, from) {
		markAsReady(error);
		const list = errorListeners.list();
		if (list.length) list.forEach((handler) => handler(error, to, from));
		else console.error(error);
		return Promise.reject(error);
	}
	function isReady() {
		if (ready && currentRoute.value !== START_LOCATION_NORMALIZED) return Promise.resolve();
		return new Promise((resolve, reject) => {
			readyHandlers.add([resolve, reject]);
		});
	}
	function markAsReady(err) {
		if (!ready) {
			ready = !err;
			setupListeners();
			readyHandlers.list().forEach(([resolve, reject]) => err ? reject(err) : resolve());
			readyHandlers.reset();
		}
		return err;
	}
	function handleScroll(to, from, isPush, isFirstNavigation) {
		const { scrollBehavior } = options;
		if (!isBrowser || !scrollBehavior) return Promise.resolve();
		const scrollPosition = !isPush && getSavedScrollPosition(getScrollKey(to.fullPath, 0)) || (isFirstNavigation || !isPush) && history.state && history.state.scroll || null;
		return nextTick().then(() => scrollBehavior(to, from, scrollPosition)).then((position) => position && scrollToPosition(position)).catch((err) => triggerError(err, to, from));
	}
	const go = (delta) => routerHistory.go(delta);
	let started;
	const installedApps = /* @__PURE__ */ new Set();
	const router = {
		currentRoute,
		listening: true,
		addRoute,
		removeRoute,
		hasRoute,
		getRoutes,
		resolve,
		options,
		push,
		replace,
		go,
		back: () => go(-1),
		forward: () => go(1),
		beforeEach: beforeGuards.add,
		beforeResolve: beforeResolveGuards.add,
		afterEach: afterGuards.add,
		onError: errorListeners.add,
		isReady,
		install(app) {
			const router = this;
			app.component("RouterLink", RouterLink);
			app.component("RouterView", RouterView);
			app.config.globalProperties.$router = router;
			Object.defineProperty(app.config.globalProperties, "$route", {
				enumerable: true,
				get: () => unref(currentRoute)
			});
			if (isBrowser && !started && currentRoute.value === START_LOCATION_NORMALIZED) {
				started = true;
				push(routerHistory.location).catch((err) => {});
			}
			const reactiveRoute = {};
			for (const key in START_LOCATION_NORMALIZED) Object.defineProperty(reactiveRoute, key, {
				get: () => currentRoute.value[key],
				enumerable: true
			});
			app.provide(routerKey, router);
			app.provide(routeLocationKey, shallowReactive(reactiveRoute));
			app.provide(routerViewLocationKey, currentRoute);
			const unmountApp = app.unmount;
			installedApps.add(app);
			app.unmount = function() {
				installedApps.delete(app);
				if (installedApps.size < 1) {
					pendingLocation = START_LOCATION_NORMALIZED;
					removeHistoryListener && removeHistoryListener();
					removeHistoryListener = null;
					currentRoute.value = START_LOCATION_NORMALIZED;
					started = false;
					ready = false;
				}
				unmountApp();
			};
		}
	};
	function runGuardQueue(guards) {
		return guards.reduce((promise, guard) => promise.then(() => runWithContext(guard)), Promise.resolve());
	}
	return router;
}
function extractChangingRecords(to, from) {
	const leavingRecords = [];
	const updatingRecords = [];
	const enteringRecords = [];
	const len = Math.max(from.matched.length, to.matched.length);
	for (let i = 0; i < len; i++) {
		const recordFrom = from.matched[i];
		if (recordFrom) if (to.matched.find((record) => isSameRouteRecord(record, recordFrom))) updatingRecords.push(recordFrom);
		else leavingRecords.push(recordFrom);
		const recordTo = to.matched[i];
		if (recordTo) {
			if (!from.matched.find((record) => isSameRouteRecord(record, recordTo))) enteringRecords.push(recordTo);
		}
	}
	return [
		leavingRecords,
		updatingRecords,
		enteringRecords
	];
}
//#endregion
//#region src/lib/shared/OrmMor.ts
var OrmMor_exports = /* @__PURE__ */ __exportAll({
	CONFIG__bin: () => CONFIG__bin,
	CONFIG_empty: () => CONFIG_empty,
	EU__bin: () => EU__bin,
	EU_empty: () => EU_empty,
	FBIND__bin: () => FBIND__bin,
	FBIND_empty: () => FBIND_empty,
	FILE__bin: () => FILE__bin,
	FILE_empty: () => FILE_empty,
	KUCP__bin: () => KUCP__bin,
	KUCP_empty: () => KUCP_empty,
	LOG__bin: () => LOG__bin,
	LOG_empty: () => LOG_empty,
	MOMENT__bin: () => MOMENT__bin,
	MOMENT_empty: () => MOMENT_empty,
	PLOG__bin: () => PLOG__bin,
	PLOG_empty: () => PLOG_empty,
	UACCT__bin: () => UACCT__bin,
	UACCT_empty: () => UACCT_empty,
	UBILL__bin: () => UBILL__bin,
	UBILL_empty: () => UBILL_empty,
	UCAT__bin: () => UCAT__bin,
	UCAT_empty: () => UCAT_empty,
	UNIT__bin: () => UNIT__bin,
	UNIT_empty: () => UNIT_empty,
	UPROVIDER__bin: () => UPROVIDER__bin,
	UPROVIDER_empty: () => UPROVIDER_empty,
	bin__CONFIG: () => bin__CONFIG,
	bin__EU: () => bin__EU,
	bin__FBIND: () => bin__FBIND,
	bin__FILE: () => bin__FILE,
	bin__KUCP: () => bin__KUCP,
	bin__LOG: () => bin__LOG,
	bin__MOMENT: () => bin__MOMENT,
	bin__PLOG: () => bin__PLOG,
	bin__UACCT: () => bin__UACCT,
	bin__UBILL: () => bin__UBILL,
	bin__UCAT: () => bin__UCAT,
	bin__UNIT: () => bin__UNIT,
	bin__UPROVIDER: () => bin__UPROVIDER,
	bin__pCONFIG: () => bin__pCONFIG,
	bin__pEU: () => bin__pEU,
	bin__pFBIND: () => bin__pFBIND,
	bin__pFILE: () => bin__pFILE,
	bin__pKUCP: () => bin__pKUCP,
	bin__pLOG: () => bin__pLOG,
	bin__pMOMENT: () => bin__pMOMENT,
	bin__pPLOG: () => bin__pPLOG,
	bin__pUACCT: () => bin__pUACCT,
	bin__pUBILL: () => bin__pUBILL,
	bin__pUCAT: () => bin__pUCAT,
	bin__pUNIT: () => bin__pUNIT,
	bin__pUPROVIDER: () => bin__pUPROVIDER,
	euAuthTypeEnum_Admin: () => 2,
	euAuthTypeEnum_Authorized: () => 1,
	euAuthTypeEnum_Normal: () => 0,
	fileStateEnum_Failed: () => 1,
	fileStateEnum_Normal: () => 0,
	momentMediaTypeEnum_Audio: () => 2,
	momentMediaTypeEnum_None: () => 0,
	momentMediaTypeEnum_Video: () => 1,
	momentStateEnum_Deleted: () => 1,
	momentStateEnum_Normal: () => 0,
	momentStateEnum_Scratch: () => 2,
	momentTypeEnum_Answer: () => 5,
	momentTypeEnum_BookmarkList: () => 6,
	momentTypeEnum_Dict: () => 9,
	momentTypeEnum_Forum: () => 3,
	momentTypeEnum_MediaFile: () => 11,
	momentTypeEnum_Miles: () => 8,
	momentTypeEnum_Original: () => 0,
	momentTypeEnum_Poll: () => 7,
	momentTypeEnum_Question: () => 4,
	momentTypeEnum_Repost: () => 1,
	momentTypeEnum_Thread: () => 2,
	momentTypeEnum_WebPage: () => 10,
	pCONFIG__bin: () => pCONFIG__bin,
	pCONFIG_empty: () => pCONFIG_empty,
	pEU__bin: () => pEU__bin,
	pEU_empty: () => pEU_empty,
	pFBIND__bin: () => pFBIND__bin,
	pFBIND_empty: () => pFBIND_empty,
	pFILE__bin: () => pFILE__bin,
	pFILE_empty: () => pFILE_empty,
	pKUCP__bin: () => pKUCP__bin,
	pKUCP_empty: () => pKUCP_empty,
	pLOG__bin: () => pLOG__bin,
	pLOG_empty: () => pLOG_empty,
	pMOMENT__bin: () => pMOMENT__bin,
	pMOMENT_empty: () => pMOMENT_empty,
	pPLOG__bin: () => pPLOG__bin,
	pPLOG_empty: () => pPLOG_empty,
	pUACCT__bin: () => pUACCT__bin,
	pUACCT_empty: () => pUACCT_empty,
	pUBILL__bin: () => pUBILL__bin,
	pUBILL_empty: () => pUBILL_empty,
	pUCAT__bin: () => pUCAT__bin,
	pUCAT_empty: () => pUCAT_empty,
	pUNIT__bin: () => pUNIT__bin,
	pUNIT_empty: () => pUNIT_empty,
	pUPROVIDER__bin: () => pUPROVIDER__bin,
	pUPROVIDER_empty: () => pUPROVIDER_empty
});
var marshall$1 = { ...bin_exports };
var pEU__bin = (bb) => (p) => {
	marshall$1.str__bin(bb)(p.Caption);
	marshall$1.str__bin(bb)(p.Username);
	marshall$1.str__bin(bb)(p.Email);
	marshall$1.str__bin(bb)(p.Avatar);
	marshall$1.str__bin(bb)(p.ClerkUserID);
	marshall$1.str__bin(bb)(p.Pwd);
	marshall$1.int32__bin(bb)(p.AuthType);
};
var EU__bin = (bb) => (v) => {
	marshall$1.int64__bin(bb)(v.id);
	marshall$1.int64__bin(bb)(v.sort);
	marshall$1.DateTime__bin(bb)(v.createdat);
	marshall$1.DateTime__bin(bb)(v.updatedat);
	pEU__bin(bb)(v.p);
};
var bin__pEU = (bi) => {
	let p = pEU_empty();
	p.Caption = marshall$1.bin__str(bi);
	p.Username = marshall$1.bin__str(bi);
	p.Email = marshall$1.bin__str(bi);
	p.Avatar = marshall$1.bin__str(bi);
	p.ClerkUserID = marshall$1.bin__str(bi);
	p.Pwd = marshall$1.bin__str(bi);
	p.AuthType = marshall$1.bin__int32(bi);
	return p;
};
var bin__EU = (bi) => {
	return {
		id: marshall$1.bin__int64(bi),
		sort: marshall$1.bin__int64(bi),
		createdat: marshall$1.bin__DateTime(bi),
		updatedat: marshall$1.bin__DateTime(bi),
		p: bin__pEU(bi)
	};
};
var pFILE__bin = (bb) => (p) => {
	marshall$1.str__bin(bb)(p.Caption);
	marshall$1.str__bin(bb)(p.Path);
	marshall$1.int32__bin(bb)(p.State);
	marshall$1.str__bin(bb)(p.ContentType);
	marshall$1.str__bin(bb)(p.Suffix);
	marshall$1.int64__bin(bb)(p.Size);
	marshall$1.int32__bin(bb)(p.Thumbnail.length);
	bb.append(p.Thumbnail);
	marshall$1.int64__bin(bb)(p.Owner);
	marshall$1.int64__bin(bb)(p.Cat);
	marshall$1.int64__bin(bb)(p.Provider);
	marshall$1.int64__bin(bb)(p.Unit);
	marshall$1.int64__bin(bb)(p.Bill);
};
var FILE__bin = (bb) => (v) => {
	marshall$1.int64__bin(bb)(v.id);
	marshall$1.int64__bin(bb)(v.sort);
	marshall$1.DateTime__bin(bb)(v.createdat);
	marshall$1.DateTime__bin(bb)(v.updatedat);
	pFILE__bin(bb)(v.p);
};
var bin__pFILE = (bi) => {
	let p = pFILE_empty();
	p.Caption = marshall$1.bin__str(bi);
	p.Path = marshall$1.bin__str(bi);
	p.State = marshall$1.bin__int32(bi);
	p.ContentType = marshall$1.bin__str(bi);
	p.Suffix = marshall$1.bin__str(bi);
	p.Size = marshall$1.bin__int64(bi);
	let lengthThumbnail = bin__int32(bi);
	p.Thumbnail = bi.bin.slice(bi.index, lengthThumbnail);
	bi.index += lengthThumbnail;
	p.Owner = marshall$1.bin__int64(bi);
	p.Cat = marshall$1.bin__int64(bi);
	p.Provider = marshall$1.bin__int64(bi);
	p.Unit = marshall$1.bin__int64(bi);
	p.Bill = marshall$1.bin__int64(bi);
	return p;
};
var bin__FILE = (bi) => {
	return {
		id: marshall$1.bin__int64(bi),
		sort: marshall$1.bin__int64(bi),
		createdat: marshall$1.bin__DateTime(bi),
		updatedat: marshall$1.bin__DateTime(bi),
		p: bin__pFILE(bi)
	};
};
var pUNIT__bin = (bb) => (p) => {
	marshall$1.str__bin(bb)(p.Caption);
	marshall$1.int64__bin(bb)(p.Owner);
	marshall$1.str__bin(bb)(p.UnitNum);
	marshall$1.str__bin(bb)(p.AcctNum);
	marshall$1.str__bin(bb)(p.Address);
	marshall$1.str__bin(bb)(p.Town);
	marshall$1.str__bin(bb)(p.State);
	marshall$1.str__bin(bb)(p.Zip);
};
var UNIT__bin = (bb) => (v) => {
	marshall$1.int64__bin(bb)(v.id);
	marshall$1.int64__bin(bb)(v.sort);
	marshall$1.DateTime__bin(bb)(v.createdat);
	marshall$1.DateTime__bin(bb)(v.updatedat);
	pUNIT__bin(bb)(v.p);
};
var bin__pUNIT = (bi) => {
	let p = pUNIT_empty();
	p.Caption = marshall$1.bin__str(bi);
	p.Owner = marshall$1.bin__int64(bi);
	p.UnitNum = marshall$1.bin__str(bi);
	p.AcctNum = marshall$1.bin__str(bi);
	p.Address = marshall$1.bin__str(bi);
	p.Town = marshall$1.bin__str(bi);
	p.State = marshall$1.bin__str(bi);
	p.Zip = marshall$1.bin__str(bi);
	return p;
};
var bin__UNIT = (bi) => {
	return {
		id: marshall$1.bin__int64(bi),
		sort: marshall$1.bin__int64(bi),
		createdat: marshall$1.bin__DateTime(bi),
		updatedat: marshall$1.bin__DateTime(bi),
		p: bin__pUNIT(bi)
	};
};
var pUACCT__bin = (bb) => (p) => {
	marshall$1.int64__bin(bb)(p.Cat);
	marshall$1.int64__bin(bb)(p.Provider);
	marshall$1.int64__bin(bb)(p.client);
	marshall$1.int64__bin(bb)(p.Unit);
	marshall$1.str__bin(bb)(p.AcctNum);
};
var UACCT__bin = (bb) => (v) => {
	marshall$1.int64__bin(bb)(v.id);
	marshall$1.int64__bin(bb)(v.sort);
	marshall$1.DateTime__bin(bb)(v.createdat);
	marshall$1.DateTime__bin(bb)(v.updatedat);
	pUACCT__bin(bb)(v.p);
};
var bin__pUACCT = (bi) => {
	let p = pUACCT_empty();
	p.Cat = marshall$1.bin__int64(bi);
	p.Provider = marshall$1.bin__int64(bi);
	p.client = marshall$1.bin__int64(bi);
	p.Unit = marshall$1.bin__int64(bi);
	p.AcctNum = marshall$1.bin__str(bi);
	return p;
};
var bin__UACCT = (bi) => {
	return {
		id: marshall$1.bin__int64(bi),
		sort: marshall$1.bin__int64(bi),
		createdat: marshall$1.bin__DateTime(bi),
		updatedat: marshall$1.bin__DateTime(bi),
		p: bin__pUACCT(bi)
	};
};
var pUBILL__bin = (bb) => (p) => {
	marshall$1.str__bin(bb)(p.ShownProvider);
	marshall$1.str__bin(bb)(p.ShownUnitNum);
	marshall$1.str__bin(bb)(p.ShownAcctNum);
	marshall$1.str__bin(bb)(p.ShownAcctName);
	marshall$1.str__bin(bb)(p.ShownAddr);
	marshall$1.str__bin(bb)(p.ShownTown);
	marshall$1.str__bin(bb)(p.ShownState);
	marshall$1.str__bin(bb)(p.ShownZip);
	marshall$1.int64__bin(bb)(p.Cat);
	marshall$1.int64__bin(bb)(p.Provider);
	marshall$1.int64__bin(bb)(p.Owner);
	marshall$1.int64__bin(bb)(p.Unit);
	marshall$1.str__bin(bb)(p.UnitText);
	marshall$1.int64__bin(bb)(p.UAcct);
	marshall$1.float__bin(bb)(p.Amt);
};
var UBILL__bin = (bb) => (v) => {
	marshall$1.int64__bin(bb)(v.id);
	marshall$1.int64__bin(bb)(v.sort);
	marshall$1.DateTime__bin(bb)(v.createdat);
	marshall$1.DateTime__bin(bb)(v.updatedat);
	pUBILL__bin(bb)(v.p);
};
var bin__pUBILL = (bi) => {
	let p = pUBILL_empty();
	p.ShownProvider = marshall$1.bin__str(bi);
	p.ShownUnitNum = marshall$1.bin__str(bi);
	p.ShownAcctNum = marshall$1.bin__str(bi);
	p.ShownAcctName = marshall$1.bin__str(bi);
	p.ShownAddr = marshall$1.bin__str(bi);
	p.ShownTown = marshall$1.bin__str(bi);
	p.ShownState = marshall$1.bin__str(bi);
	p.ShownZip = marshall$1.bin__str(bi);
	p.Cat = marshall$1.bin__int64(bi);
	p.Provider = marshall$1.bin__int64(bi);
	p.Owner = marshall$1.bin__int64(bi);
	p.Unit = marshall$1.bin__int64(bi);
	p.UnitText = marshall$1.bin__str(bi);
	p.UAcct = marshall$1.bin__int64(bi);
	p.Amt = marshall$1.bin__float(bi);
	return p;
};
var bin__UBILL = (bi) => {
	return {
		id: marshall$1.bin__int64(bi),
		sort: marshall$1.bin__int64(bi),
		createdat: marshall$1.bin__DateTime(bi),
		updatedat: marshall$1.bin__DateTime(bi),
		p: bin__pUBILL(bi)
	};
};
var pUCAT__bin = (bb) => (p) => {
	marshall$1.str__bin(bb)(p.Caption);
};
var UCAT__bin = (bb) => (v) => {
	marshall$1.int64__bin(bb)(v.id);
	marshall$1.int64__bin(bb)(v.sort);
	marshall$1.DateTime__bin(bb)(v.createdat);
	marshall$1.DateTime__bin(bb)(v.updatedat);
	pUCAT__bin(bb)(v.p);
};
var bin__pUCAT = (bi) => {
	let p = pUCAT_empty();
	p.Caption = marshall$1.bin__str(bi);
	return p;
};
var bin__UCAT = (bi) => {
	return {
		id: marshall$1.bin__int64(bi),
		sort: marshall$1.bin__int64(bi),
		createdat: marshall$1.bin__DateTime(bi),
		updatedat: marshall$1.bin__DateTime(bi),
		p: bin__pUCAT(bi)
	};
};
var pKUCP__bin = (bb) => (p) => {
	marshall$1.int64__bin(bb)(p.Cat);
	marshall$1.int64__bin(bb)(p.Provider);
};
var KUCP__bin = (bb) => (v) => {
	marshall$1.int64__bin(bb)(v.id);
	marshall$1.int64__bin(bb)(v.sort);
	marshall$1.DateTime__bin(bb)(v.createdat);
	marshall$1.DateTime__bin(bb)(v.updatedat);
	pKUCP__bin(bb)(v.p);
};
var bin__pKUCP = (bi) => {
	let p = pKUCP_empty();
	p.Cat = marshall$1.bin__int64(bi);
	p.Provider = marshall$1.bin__int64(bi);
	return p;
};
var bin__KUCP = (bi) => {
	return {
		id: marshall$1.bin__int64(bi),
		sort: marshall$1.bin__int64(bi),
		createdat: marshall$1.bin__DateTime(bi),
		updatedat: marshall$1.bin__DateTime(bi),
		p: bin__pKUCP(bi)
	};
};
var pUPROVIDER__bin = (bb) => (p) => {
	marshall$1.str__bin(bb)(p.Caption);
	marshall$1.int64__bin(bb)(p.Cat);
};
var UPROVIDER__bin = (bb) => (v) => {
	marshall$1.int64__bin(bb)(v.id);
	marshall$1.int64__bin(bb)(v.sort);
	marshall$1.DateTime__bin(bb)(v.createdat);
	marshall$1.DateTime__bin(bb)(v.updatedat);
	pUPROVIDER__bin(bb)(v.p);
};
var bin__pUPROVIDER = (bi) => {
	let p = pUPROVIDER_empty();
	p.Caption = marshall$1.bin__str(bi);
	p.Cat = marshall$1.bin__int64(bi);
	return p;
};
var bin__UPROVIDER = (bi) => {
	return {
		id: marshall$1.bin__int64(bi),
		sort: marshall$1.bin__int64(bi),
		createdat: marshall$1.bin__DateTime(bi),
		updatedat: marshall$1.bin__DateTime(bi),
		p: bin__pUPROVIDER(bi)
	};
};
var pFBIND__bin = (bb) => (p) => {
	marshall$1.int64__bin(bb)(p.File);
	marshall$1.int64__bin(bb)(p.Moment);
	marshall$1.str__bin(bb)(p.Desc);
};
var FBIND__bin = (bb) => (v) => {
	marshall$1.int64__bin(bb)(v.id);
	marshall$1.int64__bin(bb)(v.sort);
	marshall$1.DateTime__bin(bb)(v.createdat);
	marshall$1.DateTime__bin(bb)(v.updatedat);
	pFBIND__bin(bb)(v.p);
};
var bin__pFBIND = (bi) => {
	let p = pFBIND_empty();
	p.File = marshall$1.bin__int64(bi);
	p.Moment = marshall$1.bin__int64(bi);
	p.Desc = marshall$1.bin__str(bi);
	return p;
};
var bin__FBIND = (bi) => {
	return {
		id: marshall$1.bin__int64(bi),
		sort: marshall$1.bin__int64(bi),
		createdat: marshall$1.bin__DateTime(bi),
		updatedat: marshall$1.bin__DateTime(bi),
		p: bin__pFBIND(bi)
	};
};
var pMOMENT__bin = (bb) => (p) => {
	marshall$1.str__bin(bb)(p.Title);
	marshall$1.str__bin(bb)(p.Summary);
	marshall$1.str__bin(bb)(p.FullText);
	marshall$1.str__bin(bb)(p.PreviewImgUrl);
	marshall$1.str__bin(bb)(p.Link);
	marshall$1.int32__bin(bb)(p.Type);
	marshall$1.int32__bin(bb)(p.State);
	marshall$1.int32__bin(bb)(p.MediaType);
};
var MOMENT__bin = (bb) => (v) => {
	marshall$1.int64__bin(bb)(v.id);
	marshall$1.int64__bin(bb)(v.sort);
	marshall$1.DateTime__bin(bb)(v.createdat);
	marshall$1.DateTime__bin(bb)(v.updatedat);
	pMOMENT__bin(bb)(v.p);
};
var bin__pMOMENT = (bi) => {
	let p = pMOMENT_empty();
	p.Title = marshall$1.bin__str(bi);
	p.Summary = marshall$1.bin__str(bi);
	p.FullText = marshall$1.bin__str(bi);
	p.PreviewImgUrl = marshall$1.bin__str(bi);
	p.Link = marshall$1.bin__str(bi);
	p.Type = marshall$1.bin__int32(bi);
	p.State = marshall$1.bin__int32(bi);
	p.MediaType = marshall$1.bin__int32(bi);
	return p;
};
var bin__MOMENT = (bi) => {
	return {
		id: marshall$1.bin__int64(bi),
		sort: marshall$1.bin__int64(bi),
		createdat: marshall$1.bin__DateTime(bi),
		updatedat: marshall$1.bin__DateTime(bi),
		p: bin__pMOMENT(bi)
	};
};
var pCONFIG__bin = (bb) => (p) => {
	marshall$1.str__bin(bb)(p.Key);
	marshall$1.str__bin(bb)(p.Val);
};
var CONFIG__bin = (bb) => (v) => {
	marshall$1.int64__bin(bb)(v.id);
	marshall$1.int64__bin(bb)(v.sort);
	marshall$1.DateTime__bin(bb)(v.createdat);
	marshall$1.DateTime__bin(bb)(v.updatedat);
	pCONFIG__bin(bb)(v.p);
};
var bin__pCONFIG = (bi) => {
	let p = pCONFIG_empty();
	p.Key = marshall$1.bin__str(bi);
	p.Val = marshall$1.bin__str(bi);
	return p;
};
var bin__CONFIG = (bi) => {
	return {
		id: marshall$1.bin__int64(bi),
		sort: marshall$1.bin__int64(bi),
		createdat: marshall$1.bin__DateTime(bi),
		updatedat: marshall$1.bin__DateTime(bi),
		p: bin__pCONFIG(bi)
	};
};
var pLOG__bin = (bb) => (p) => {
	marshall$1.str__bin(bb)(p.Location);
	marshall$1.str__bin(bb)(p.Content);
	marshall$1.str__bin(bb)(p.Sql);
};
var LOG__bin = (bb) => (v) => {
	marshall$1.int64__bin(bb)(v.id);
	marshall$1.int64__bin(bb)(v.sort);
	marshall$1.DateTime__bin(bb)(v.createdat);
	marshall$1.DateTime__bin(bb)(v.updatedat);
	pLOG__bin(bb)(v.p);
};
var bin__pLOG = (bi) => {
	let p = pLOG_empty();
	p.Location = marshall$1.bin__str(bi);
	p.Content = marshall$1.bin__str(bi);
	p.Sql = marshall$1.bin__str(bi);
	return p;
};
var bin__LOG = (bi) => {
	return {
		id: marshall$1.bin__int64(bi),
		sort: marshall$1.bin__int64(bi),
		createdat: marshall$1.bin__DateTime(bi),
		updatedat: marshall$1.bin__DateTime(bi),
		p: bin__pLOG(bi)
	};
};
var pPLOG__bin = (bb) => (p) => {
	marshall$1.str__bin(bb)(p.Ip);
	marshall$1.str__bin(bb)(p.Request);
};
var PLOG__bin = (bb) => (v) => {
	marshall$1.int64__bin(bb)(v.id);
	marshall$1.int64__bin(bb)(v.sort);
	marshall$1.DateTime__bin(bb)(v.createdat);
	marshall$1.DateTime__bin(bb)(v.updatedat);
	pPLOG__bin(bb)(v.p);
};
var bin__pPLOG = (bi) => {
	let p = pPLOG_empty();
	p.Ip = marshall$1.bin__str(bi);
	p.Request = marshall$1.bin__str(bi);
	return p;
};
var bin__PLOG = (bi) => {
	return {
		id: marshall$1.bin__int64(bi),
		sort: marshall$1.bin__int64(bi),
		createdat: marshall$1.bin__DateTime(bi),
		updatedat: marshall$1.bin__DateTime(bi),
		p: bin__pPLOG(bi)
	};
};
var pEU_empty = () => {
	return {
		Caption: "",
		Username: "",
		Email: "",
		Avatar: "",
		ClerkUserID: "",
		Pwd: "",
		AuthType: 0
	};
};
var EU_empty = () => {
	return {
		id: 0,
		createdat: /* @__PURE__ */ new Date(),
		updatedat: /* @__PURE__ */ new Date(),
		sort: 0,
		p: pEU_empty()
	};
};
var pFILE_empty = () => {
	return {
		Caption: "",
		Path: "",
		State: 0,
		ContentType: "",
		Suffix: "",
		Size: 0,
		Thumbnail: [],
		Owner: 0,
		Cat: 0,
		Provider: 0,
		Unit: 0,
		Bill: 0
	};
};
var FILE_empty = () => {
	return {
		id: 0,
		createdat: /* @__PURE__ */ new Date(),
		updatedat: /* @__PURE__ */ new Date(),
		sort: 0,
		p: pFILE_empty()
	};
};
var pUNIT_empty = () => {
	return {
		Caption: "",
		Owner: 0,
		UnitNum: "",
		AcctNum: "",
		Address: "",
		Town: "",
		State: "",
		Zip: ""
	};
};
var UNIT_empty = () => {
	return {
		id: 0,
		createdat: /* @__PURE__ */ new Date(),
		updatedat: /* @__PURE__ */ new Date(),
		sort: 0,
		p: pUNIT_empty()
	};
};
var pUACCT_empty = () => {
	return {
		Cat: 0,
		Provider: 0,
		client: 0,
		Unit: 0,
		AcctNum: ""
	};
};
var UACCT_empty = () => {
	return {
		id: 0,
		createdat: /* @__PURE__ */ new Date(),
		updatedat: /* @__PURE__ */ new Date(),
		sort: 0,
		p: pUACCT_empty()
	};
};
var pUBILL_empty = () => {
	return {
		ShownProvider: "",
		ShownUnitNum: "",
		ShownAcctNum: "",
		ShownAcctName: "",
		ShownAddr: "",
		ShownTown: "",
		ShownState: "",
		ShownZip: "",
		Cat: 0,
		Provider: 0,
		Owner: 0,
		Unit: 0,
		UnitText: "",
		UAcct: 0,
		Amt: 0
	};
};
var UBILL_empty = () => {
	return {
		id: 0,
		createdat: /* @__PURE__ */ new Date(),
		updatedat: /* @__PURE__ */ new Date(),
		sort: 0,
		p: pUBILL_empty()
	};
};
var pUCAT_empty = () => {
	return { Caption: "" };
};
var UCAT_empty = () => {
	return {
		id: 0,
		createdat: /* @__PURE__ */ new Date(),
		updatedat: /* @__PURE__ */ new Date(),
		sort: 0,
		p: pUCAT_empty()
	};
};
var pKUCP_empty = () => {
	return {
		Cat: 0,
		Provider: 0
	};
};
var KUCP_empty = () => {
	return {
		id: 0,
		createdat: /* @__PURE__ */ new Date(),
		updatedat: /* @__PURE__ */ new Date(),
		sort: 0,
		p: pKUCP_empty()
	};
};
var pUPROVIDER_empty = () => {
	return {
		Caption: "",
		Cat: 0
	};
};
var UPROVIDER_empty = () => {
	return {
		id: 0,
		createdat: /* @__PURE__ */ new Date(),
		updatedat: /* @__PURE__ */ new Date(),
		sort: 0,
		p: pUPROVIDER_empty()
	};
};
var pFBIND_empty = () => {
	return {
		File: 0,
		Moment: 0,
		Desc: ""
	};
};
var FBIND_empty = () => {
	return {
		id: 0,
		createdat: /* @__PURE__ */ new Date(),
		updatedat: /* @__PURE__ */ new Date(),
		sort: 0,
		p: pFBIND_empty()
	};
};
var pMOMENT_empty = () => {
	return {
		Title: "",
		Summary: "",
		FullText: "",
		PreviewImgUrl: "",
		Link: "",
		Type: 0,
		State: 0,
		MediaType: 0
	};
};
var MOMENT_empty = () => {
	return {
		id: 0,
		createdat: /* @__PURE__ */ new Date(),
		updatedat: /* @__PURE__ */ new Date(),
		sort: 0,
		p: pMOMENT_empty()
	};
};
var pCONFIG_empty = () => {
	return {
		Key: "",
		Val: ""
	};
};
var CONFIG_empty = () => {
	return {
		id: 0,
		createdat: /* @__PURE__ */ new Date(),
		updatedat: /* @__PURE__ */ new Date(),
		sort: 0,
		p: pCONFIG_empty()
	};
};
var pLOG_empty = () => {
	return {
		Location: "",
		Content: "",
		Sql: ""
	};
};
var LOG_empty = () => {
	return {
		id: 0,
		createdat: /* @__PURE__ */ new Date(),
		updatedat: /* @__PURE__ */ new Date(),
		sort: 0,
		p: pLOG_empty()
	};
};
var pPLOG_empty = () => {
	return {
		Ip: "",
		Request: ""
	};
};
var PLOG_empty = () => {
	return {
		id: 0,
		createdat: /* @__PURE__ */ new Date(),
		updatedat: /* @__PURE__ */ new Date(),
		sort: 0,
		p: pPLOG_empty()
	};
};
//#endregion
//#region src/lib/shared/CustomMor.ts
var CustomMor_exports = /* @__PURE__ */ __exportAll({
	BillComplex__bin: () => BillComplex__bin,
	BillComplex_empty: () => BillComplex_empty,
	ClientRuntime__bin: () => ClientRuntime__bin,
	ClientRuntime_empty: () => ClientRuntime_empty,
	ErEnum: () => ErEnum,
	Er__bin: () => Er__bin,
	Er_empty: () => Er_empty,
	EuComplex__bin: () => EuComplex__bin,
	EuComplex_empty: () => EuComplex_empty,
	MomentComplex__bin: () => MomentComplex__bin,
	MomentComplex_empty: () => MomentComplex_empty,
	MsgEnum: () => MsgEnum,
	Msg__bin: () => Msg__bin,
	Msg_empty: () => Msg_empty,
	RuntimeData__bin: () => RuntimeData__bin,
	RuntimeData_empty: () => RuntimeData_empty,
	bin__BillComplex: () => bin__BillComplex,
	bin__ClientRuntime: () => bin__ClientRuntime,
	bin__Er: () => bin__Er,
	bin__EuComplex: () => bin__EuComplex,
	bin__MomentComplex: () => bin__MomentComplex,
	bin__Msg: () => bin__Msg,
	bin__RuntimeData: () => bin__RuntimeData
});
var marshall = {
	...bin_exports,
	...OrmMor_exports
};
var MsgEnum = /* @__PURE__ */ function(MsgEnum) {
	MsgEnum[MsgEnum["Heartbeat"] = 0] = "Heartbeat";
	MsgEnum[MsgEnum["ApiRequest"] = 1] = "ApiRequest";
	MsgEnum[MsgEnum["ApiResponse"] = 2] = "ApiResponse";
	return MsgEnum;
}({});
var ErEnum = /* @__PURE__ */ function(ErEnum) {
	ErEnum[ErEnum["ApiNotExists"] = 0] = "ApiNotExists";
	ErEnum[ErEnum["InvalideParameter"] = 1] = "InvalideParameter";
	ErEnum[ErEnum["Unauthorized"] = 2] = "Unauthorized";
	ErEnum[ErEnum["NotAvailable"] = 3] = "NotAvailable";
	ErEnum[ErEnum["Internal"] = 4] = "Internal";
	ErEnum[ErEnum["API3rdParty"] = 5] = "API3rdParty";
	return ErEnum;
}({});
var BillComplex_empty = () => {
	return {
		cato: null,
		providero: null,
		owner: {
			id: 0,
			sort: 0,
			createdat: /* @__PURE__ */ new Date(),
			updatedat: /* @__PURE__ */ new Date(),
			p: marshall.pEU_empty()
		},
		unito: null,
		accto: null,
		files: [],
		bill: {
			id: 0,
			sort: 0,
			createdat: /* @__PURE__ */ new Date(),
			updatedat: /* @__PURE__ */ new Date(),
			p: marshall.pUBILL_empty()
		}
	};
};
var BillComplex__bin = (bb) => (v) => {
	marshall.option__bin(marshall.UCAT__bin)(bb)(v.cato);
	marshall.option__bin(marshall.UPROVIDER__bin)(bb)(v.providero);
	marshall.EU__bin(bb)(v.owner);
	marshall.option__bin(marshall.UNIT__bin)(bb)(v.unito);
	marshall.option__bin(marshall.UACCT__bin)(bb)(v.accto);
	marshall.array__bin(marshall.FILE__bin)(bb)(v.files);
	marshall.UBILL__bin(bb)(v.bill);
};
var bin__BillComplex = (bi) => {
	return {
		cato: marshall.bin__option(marshall.bin__UCAT)(bi),
		providero: marshall.bin__option(marshall.bin__UPROVIDER)(bi),
		owner: marshall.bin__EU(bi),
		unito: marshall.bin__option(marshall.bin__UNIT)(bi),
		accto: marshall.bin__option(marshall.bin__UACCT)(bi),
		files: marshall.bin__array(marshall.bin__FILE)(bi),
		bill: marshall.bin__UBILL(bi)
	};
};
var EuComplex_empty = () => {
	return {
		units: {},
		billxs: {},
		eu: {
			id: 0,
			sort: 0,
			createdat: /* @__PURE__ */ new Date(),
			updatedat: /* @__PURE__ */ new Date(),
			p: marshall.pEU_empty()
		}
	};
};
var EuComplex__bin = (bb) => (v) => {
	marshall.dict__bin(marshall.int64__bin)(marshall.UNIT__bin)(bb)(v.units);
	marshall.dict__bin(marshall.int64__bin)(BillComplex__bin)(bb)(v.billxs);
	marshall.EU__bin(bb)(v.eu);
};
var bin__EuComplex = (bi) => {
	return {
		units: marshall.bin__dict(marshall.bin__int64)(marshall.bin__UNIT)(bi),
		billxs: marshall.bin__dict(marshall.bin__int64)(bin__BillComplex)(bi),
		eu: marshall.bin__EU(bi)
	};
};
var MomentComplex_empty = () => {
	return { m: {
		id: 0,
		sort: 0,
		createdat: /* @__PURE__ */ new Date(),
		updatedat: /* @__PURE__ */ new Date(),
		p: marshall.pMOMENT_empty()
	} };
};
var MomentComplex__bin = (bb) => (v) => {
	marshall.MOMENT__bin(bb)(v.m);
};
var bin__MomentComplex = (bi) => {
	return { m: marshall.bin__MOMENT(bi) };
};
var RuntimeData_empty = () => {
	return {
		apiKeyGemini: "",
		aiModel: "",
		cats: {},
		providers: {},
		catproviders: []
	};
};
var RuntimeData__bin = (bb) => (v) => {
	marshall.str__bin(bb)(v.apiKeyGemini);
	marshall.str__bin(bb)(v.aiModel);
	marshall.dict__bin(marshall.int64__bin)(marshall.UCAT__bin)(bb)(v.cats);
	marshall.dict__bin(marshall.int64__bin)(marshall.UPROVIDER__bin)(bb)(v.providers);
	marshall.array__bin(marshall.KUCP__bin)(bb)(v.catproviders);
};
var bin__RuntimeData = (bi) => {
	return {
		apiKeyGemini: marshall.bin__str(bi),
		aiModel: marshall.bin__str(bi),
		cats: marshall.bin__dict(marshall.bin__int64)(marshall.bin__UCAT)(bi),
		providers: marshall.bin__dict(marshall.bin__int64)(marshall.bin__UPROVIDER)(bi),
		catproviders: marshall.bin__array(marshall.bin__KUCP)(bi)
	};
};
var ClientRuntime_empty = () => {
	return { version: 0 };
};
var ClientRuntime__bin = (bb) => (v) => {
	marshall.int32__bin(bb)(v.version);
};
var bin__ClientRuntime = (bi) => {
	return { version: marshall.bin__int32(bi) };
};
var Msg_empty = () => {
	return {
		e: 0,
		val: {}
	};
};
var Msg__bin = (bb) => (v) => {
	marshall.int32__bin(bb)(v.e);
	switch (v.e) {
		case 0: break;
		case 1:
			marshall.Json__bin(bb)(v.val);
			break;
		case 2:
			marshall.Json__bin(bb)(v.val);
			break;
	}
};
var bin__Msg = (bi) => {
	let v = {
		e: 0,
		val: {}
	};
	v.e = marshall.bin__int32(bi);
	switch (v.e) {
		case 2:
			v.val = marshall.bin__Json(bi);
			break;
		case 1:
			v.val = marshall.bin__Json(bi);
			break;
		case 0: break;
	}
	return v;
};
var Er_empty = () => {
	return {
		e: 0,
		val: {}
	};
};
var Er__bin = (bb) => (v) => {
	marshall.int32__bin(bb)(v.e);
	switch (v.e) {
		case 0: break;
		case 1: break;
		case 2: break;
		case 3: break;
		case 4: break;
		case 5: break;
	}
};
var bin__Er = (bi) => {
	let v = {
		e: 0,
		val: {}
	};
	v.e = marshall.bin__int32(bi);
	switch (v.e) {
		case 5: break;
		case 4: break;
		case 3: break;
		case 2: break;
		case 1: break;
		case 0: break;
	}
	return v;
};
//#endregion
//#region src/comps/BillFile.vue?vue&type=script&setup=true&lang.ts
var _hoisted_1$7 = { class: "h-full w-full flex flex-col p-3" };
var _hoisted_2$7 = {
	key: 0,
	class: "w-[300px]"
};
var _hoisted_3$6 = ["src"];
var _hoisted_4$5 = { key: 1 };
var _hoisted_5$5 = { key: 0 };
var _hoisted_6$4 = { key: 1 };
var _hoisted_7$2 = { key: 2 };
var _hoisted_8$2 = { key: 3 };
var _hoisted_9$1 = { key: 4 };
var _hoisted_10$1 = { class: "progress-container" };
var _hoisted_11$1 = { class: "status-row" };
var _hoisted_12$1 = {
	key: 0,
	class: "error-detail"
};
var BillFile_vue_vue_type_script_setup_true_lang_default = /* @__PURE__ */ defineComponent({
	__name: "BillFile",
	props: ["filex"],
	setup(__props) {
		const props = __props;
		props.filex;
		const s = glib.vue.reactive({
			billx: BillComplex_empty(),
			rt: runtime
		});
		const getStatusText = (task) => {
			switch (task.status) {
				case "uploading": return "Uploading ...";
				case "success": return "Succeeded";
				case "error": return "Failed";
				default: return "Pending ...";
			}
		};
		const executeUpload = async (task) => {
			task.status = "uploading";
			task.progress = 0;
			const token = await window.Clerk?.session?.getToken();
			const formData = new FormData();
			formData.append("file", task.file);
			formData.append("session", s.rt.session);
			return new Promise((resolve, reject) => {
				const xhr = new XMLHttpRequest();
				xhr.upload.onprogress = (event) => {
					if (event.lengthComputable) {
						const percent = Math.round(event.loaded * 100 / event.total);
						task.progress = Math.min(percent, 99);
					}
				};
				xhr.onload = () => {
					if (xhr.status >= 200 && xhr.status < 300) try {
						let rep = JSON.parse(xhr.responseText);
						if (rep.Er == "OK") {
							props.filex.rcd = rep.file;
							s.billx = rep.billx;
						}
						task.status = "success";
						task.progress = 100;
						resolve(rep);
					} catch (e) {
						task.status = "error";
						task.message = "Invalid JSON response";
						reject("Invalid JSON");
					}
					else {
						task.status = "error";
						task.message = `Server Error: ${xhr.status}`;
						reject(xhr.status);
					}
				};
				xhr.onerror = () => {
					task.status = "error";
					task.message = "Network error or file too large";
					console.error("Upload failed");
					reject("Network error");
				};
				xhr.open("POST", "/api/public/upload");
				if (token) xhr.setRequestHeader("Authorization", `Bearer ${token}`);
				xhr.send(formData);
			});
		};
		glib.vue.onMounted(async () => {
			executeUpload(props.filex.uploadTask);
		});
		return (_ctx, _cache) => {
			return openBlock(), createElementBlock("div", _hoisted_1$7, [
				props.filex.rcd.id > 0 ? (openBlock(), createElementBlock("div", _hoisted_2$7, [createBaseVNode("img", { src: "/thumbnail/" + props.filex.rcd.id }, null, 8, _hoisted_3$6)])) : createCommentVNode("", true),
				props.filex.rcd.id > 0 ? (openBlock(), createElementBlock("div", _hoisted_4$5, [
					unref(s).billx.cato ? (openBlock(), createElementBlock("div", _hoisted_5$5, "Cat: " + toDisplayString(unref(s).billx.cato?.p.Caption), 1)) : createCommentVNode("", true),
					unref(s).billx.providero ? (openBlock(), createElementBlock("div", _hoisted_6$4, "Provider: " + toDisplayString(unref(s).billx.providero?.p.Caption), 1)) : createCommentVNode("", true),
					unref(s).billx.unito ? (openBlock(), createElementBlock("div", _hoisted_7$2, "Unit: " + toDisplayString(unref(s).billx.unito?.p.Caption), 1)) : createCommentVNode("", true),
					unref(s).billx.accto ? (openBlock(), createElementBlock("div", _hoisted_8$2, "Acct Number: " + toDisplayString(unref(s).billx.accto?.p.AcctNum), 1)) : createCommentVNode("", true),
					unref(s).billx.bill.id > 0 ? (openBlock(), createElementBlock("div", _hoisted_9$1, "Amount: " + toDisplayString(unref(s).billx.bill.p.Amout), 1)) : createCommentVNode("", true),
					createBaseVNode("div", null, "File Name: " + toDisplayString(props.filex.file.name), 1),
					createBaseVNode("div", null, "File Size: " + toDisplayString((props.filex.file.size / 1024 / 1024).toFixed(2)) + " MB", 1)
				])) : createCommentVNode("", true),
				createBaseVNode("div", _hoisted_10$1, [createBaseVNode("div", {
					class: normalizeClass(["progress-fill", __props.filex.uploadTask.status]),
					style: normalizeStyle({ width: props.filex.uploadTask.progress + "%" })
				}, null, 6)]),
				createBaseVNode("div", _hoisted_11$1, [createBaseVNode("span", { class: normalizeClass(["status-label", props.filex.uploadTask.status]) }, toDisplayString(getStatusText(props.filex.uploadTask)), 3), props.filex.uploadTask.message ? (openBlock(), createElementBlock("span", _hoisted_12$1, " - " + toDisplayString(props.filex.uploadTask.message), 1)) : createCommentVNode("", true)])
			]);
		};
	}
});
//#endregion
//#region \0plugin-vue:export-helper
var _plugin_vue_export_helper_default = (sfc, props) => {
	const target = sfc.__vccOpts || sfc;
	for (const [key, val] of props) target[key] = val;
	return target;
};
//#endregion
//#region src/comps/BillFile.vue
var BillFile_default = /* @__PURE__ */ _plugin_vue_export_helper_default(BillFile_vue_vue_type_script_setup_true_lang_default, [["__scopeId", "data-v-6ada0c57"]]);
//#endregion
//#region src/pages/UploadBills.vue?vue&type=script&setup=true&lang.ts
var _withScopeId = (n) => (pushScopeId("data-v-48675402"), n = n(), popScopeId(), n);
var _hoisted_1$6 = { class: "upload-page" };
var _hoisted_2$6 = { class: "card" };
var _hoisted_3$5 = /* @__PURE__ */ _withScopeId(() => /* @__PURE__ */ createBaseVNode("div", { class: "header" }, [/* @__PURE__ */ createBaseVNode("h2", null, "Upload Bills")], -1));
var _hoisted_4$4 = /* @__PURE__ */ _withScopeId(() => /* @__PURE__ */ createBaseVNode("div", null, [/* @__PURE__ */ createBaseVNode("p", null, [/* @__PURE__ */ createTextVNode("Drop your files here or "), /* @__PURE__ */ createBaseVNode("span", null, "Select")]), /* @__PURE__ */ createBaseVNode("small", null, "Max. 10GB")], -1));
var _hoisted_5$4 = /* @__PURE__ */ _withScopeId(() => /* @__PURE__ */ createBaseVNode("div", { class: "icon" }, "📄", -1));
var _hoisted_6$3 = { class: "card" };
var _hoisted_7$1 = /* @__PURE__ */ _withScopeId(() => /* @__PURE__ */ createBaseVNode("div", null, "File list", -1));
var _hoisted_8$1 = { class: "flex flex-wrap gap-4 p-4" };
//#endregion
//#region src/pages/UploadBills.vue
var UploadBills_default = /* @__PURE__ */ _plugin_vue_export_helper_default(/* @__PURE__ */ defineComponent({
	__name: "UploadBills",
	setup(__props) {
		const s = glib.vue.reactive({
			filexs: [],
			rep: {},
			rt: runtime
		});
		const isDragging = ref(false);
		const fileInput = ref(null);
		const triggerSelect = () => fileInput.value?.click();
		const onFileSelect = (e) => {
			const files = e.target.files;
			handleFiles(files);
		};
		const onDrop = (e) => {
			isDragging.value = false;
			handleFiles(e.dataTransfer?.files || null);
		};
		const handleFiles = (fileList) => {
			if (!fileList) return;
			Array.from(fileList).forEach((file) => {
				let filex = {
					uploadTask: {},
					rcd: FILE_empty(),
					file
				};
				filex.uploadTask = {
					id: Math.random().toString(36).slice(2),
					file,
					progress: 0,
					status: "pending"
				};
				s.filexs.push(filex);
			});
		};
		const upload = async () => {
			let fids = s.filexs.map((filex) => filex.rcd.id);
			sessionStorage.setItem("fids", JSON.stringify(fids));
			await router.push("/ReviewBills");
		};
		return (_ctx, _cache) => {
			return openBlock(), createElementBlock("div", _hoisted_1$6, [createBaseVNode("div", _hoisted_2$6, [
				_hoisted_3$5,
				_hoisted_4$4,
				createBaseVNode("div", {
					class: normalizeClass(["drop-zone", { "is-dragging": isDragging.value }]),
					onDragover: _cache[0] || (_cache[0] = withModifiers(($event) => isDragging.value = true, ["prevent"])),
					onDragleave: _cache[1] || (_cache[1] = withModifiers(($event) => isDragging.value = false, ["prevent"])),
					onDrop: withModifiers(onDrop, ["prevent"]),
					onClick: triggerSelect
				}, [createBaseVNode("input", {
					type: "file",
					multiple: "",
					ref_key: "fileInput",
					ref: fileInput,
					onChange: onFileSelect,
					hidden: ""
				}, null, 544), _hoisted_5$4], 34)
			]), createBaseVNode("div", _hoisted_6$3, [
				_hoisted_7$1,
				createBaseVNode("div", _hoisted_8$1, [(openBlock(true), createElementBlock(Fragment, null, renderList(unref(s).filexs, (filex) => {
					return openBlock(), createBlock(BillFile_default, {
						class: "w-48 h-32 bg-slate-100 border-2 border-dashed border-slate-300 rounded-lg flex",
						filex
					}, null, 8, ["filex"]);
				}), 256))]),
				createBaseVNode("div", null, [createBaseVNode("button", { onClick: upload }, "Upload")])
			])]);
		};
	}
}), [["__scopeId", "data-v-48675402"]]);
//#endregion
//#region src/lib/store/common.ts
var loader = async (url, post, h, ex = () => {}) => {
	post.session = runtime.session;
	let rep = await glib.post(url, post);
	if (rep.Er == "OK") h(rep);
	else ex(rep);
};
//#endregion
//#region src/comps/SearchField.vue?vue&type=script&setup=true&lang.ts
var _hoisted_1$5 = { class: "relative w-[200px]" };
var _hoisted_2$5 = {
	key: 0,
	class: "absolute z-10 w-full bg-white border rounded shadow-lg mt-1 max-h-48 overflow-y-auto"
};
var _hoisted_3$4 = ["onClick", "value"];
//#endregion
//#region src/comps/SearchField.vue
var SearchField_default = /* @__PURE__ */ defineComponent({
	__name: "SearchField",
	props: [
		"api",
		"item__key",
		"item__text"
	],
	emits: ["select"],
	setup(__props, { emit: __emit }) {
		const props = __props;
		props.api;
		props.item__key;
		props.item__text;
		const s = glib.vue.reactive({ opts: [] });
		const emits = __emit;
		const searchText = ref("");
		const isDropdownVisible = ref(false);
		const onInput = () => {
			if (!searchText.value) return;
			loader(props.api, {
				term: searchText.value,
				act: "search"
			}, (rep) => {
				s.opts = rep.data;
				console.log(s.opts);
			}, () => {});
		};
		const selectOption = (opt) => {
			searchText.value = props.item__key(opt);
			isDropdownVisible.value = false;
			emits("select", opt);
		};
		const onBlur = () => {
			setTimeout(() => isDropdownVisible.value = false, 200);
		};
		return (_ctx, _cache) => {
			return openBlock(), createElementBlock("div", _hoisted_1$5, [withDirectives(createBaseVNode("input", {
				type: "text",
				"onUpdate:modelValue": _cache[0] || (_cache[0] = ($event) => searchText.value = $event),
				onFocus: _cache[1] || (_cache[1] = ($event) => isDropdownVisible.value = true),
				onBlur,
				onInput,
				placeholder: "Start typing...",
				class: "w-full border rounded px-3 py-2 focus:ring-2 focus:ring-blue-500 outline-none"
			}, null, 544), [[vModelText, searchText.value]]), isDropdownVisible.value && unref(s).opts.length > 0 ? (openBlock(), createElementBlock("ul", _hoisted_2$5, [(openBlock(true), createElementBlock(Fragment, null, renderList(unref(s).opts, (opt) => {
				return openBlock(), createElementBlock("li", {
					onClick: ($event) => selectOption(opt),
					value: props.item__key(opt),
					class: "px-3 py-2 hover:bg-blue-50 cursor-pointer text-sm"
				}, toDisplayString(props.item__text(opt)), 9, _hoisted_3$4);
			}), 256))])) : createCommentVNode("", true)]);
		};
	}
});
//#endregion
//#region src/comps/StateLocator.vue?vue&type=script&setup=true&lang.ts
var _hoisted_51 = [/* @__PURE__ */ createStaticVNode("<option value=\"AL\">AL Alabama</option><option value=\"AK\">AK Alaska</option><option value=\"AZ\">AZ Arizona</option><option value=\"AR\">AR Arkansas</option><option value=\"CA\">CA California</option><option value=\"CO\">CO Colorado</option><option value=\"CT\">CT Connecticut</option><option value=\"DE\">DE Delaware</option><option value=\"FL\">FL Florida</option><option value=\"GA\">GA Georgia</option><option value=\"HI\">HI Hawaii</option><option value=\"ID\">ID Idaho</option><option value=\"IL\">IL Illinois</option><option value=\"IN\">IN Indiana</option><option value=\"IA\">IA Iowa</option><option value=\"KS\">KS Kansas</option><option value=\"KY\">KY Kentucky</option><option value=\"LA\">LA Louisiana</option><option value=\"ME\">ME Maine</option><option value=\"MD\">MD Maryland</option><option value=\"MA\">MA Massachusetts</option><option value=\"MI\">MI Michigan</option><option value=\"MN\">MN Minnesota</option><option value=\"MS\">MS Mississippi</option><option value=\"MO\">MO Missouri</option><option value=\"MT\">MT Montana</option><option value=\"NE\">NE Nebraska</option><option value=\"NV\">NV Nevada</option><option value=\"NH\">NH New Hampshire</option><option value=\"NJ\">NJ New Jersey</option><option value=\"NM\">NM New Mexico</option><option value=\"NY\">NY New York</option><option value=\"NC\">NC North Carolina</option><option value=\"ND\">ND North Dakota</option><option value=\"OH\">OH Ohio</option><option value=\"OK\">OK Oklahoma</option><option value=\"OR\">OR Oregon</option><option value=\"PA\">PA Pennsylvania</option><option value=\"RI\">RI Rhode Island</option><option value=\"SC\">SC South Carolina</option><option value=\"SD\">SD South Dakota</option><option value=\"TN\">TN Tennessee</option><option value=\"TX\">TX Texas</option><option value=\"UT\">UT Utah</option><option value=\"VT\">VT Vermont</option><option value=\"VA\">VA Virginia</option><option value=\"WA\">WA Washington</option><option value=\"WV\">WV West Virginia</option><option value=\"WI\">WI Wisconsin</option><option value=\"WY\">WY Wyoming</option>", 50)];
//#endregion
//#region src/comps/StateLocator.vue
var StateLocator_default = /* @__PURE__ */ defineComponent({
	__name: "StateLocator",
	props: {
		"modelValue": {},
		"modelModifiers": {}
	},
	emits: ["update:modelValue"],
	setup(__props) {
		const state = useModel(__props, "modelValue");
		glib.vue.onMounted(async () => {
			console.log(state.value);
		});
		return (_ctx, _cache) => {
			return openBlock(), createElementBlock("div", null, [withDirectives(createBaseVNode("select", { "onUpdate:modelValue": _cache[0] || (_cache[0] = ($event) => state.value = $event) }, _hoisted_51, 512), [[vModelSelect, state.value]])]);
		};
	}
});
//#endregion
//#region src/pages/ReviewBills.vue?vue&type=script&setup=true&lang.ts
var _hoisted_1$4 = /* @__PURE__ */ createBaseVNode("h2", null, "Review Bills", -1);
var _hoisted_2$4 = { class: "w-[300px]" };
var _hoisted_3$3 = ["src"];
var _hoisted_4$3 = { key: 0 };
var _hoisted_5$3 = {
	key: 0,
	class: "my-2 p-2 bg-[#eeeeff]"
};
var _hoisted_6$2 = /* @__PURE__ */ createBaseVNode("p", null, "We experienced an issue from the AI. You can keyin the fields instead.", -1);
var _hoisted_7 = /* @__PURE__ */ createBaseVNode("h2", null, "Unit", -1);
var _hoisted_8 = { class: "my-2 p-2 bg-[#eeeeff]" };
var _hoisted_9 = /* @__PURE__ */ createBaseVNode("div", null, "Address: ", -1);
var _hoisted_10 = /* @__PURE__ */ createBaseVNode("div", null, "Town: ", -1);
var _hoisted_11 = /* @__PURE__ */ createBaseVNode("div", null, "State: ", -1);
var _hoisted_12 = /* @__PURE__ */ createBaseVNode("div", null, "ZIP: ", -1);
var _hoisted_13 = /* @__PURE__ */ createBaseVNode("div", null, "Match existing unit", -1);
var _hoisted_14 = { class: "flex" };
var _hoisted_15 = { key: 0 };
var _hoisted_16 = /* @__PURE__ */ createBaseVNode("h2", null, "Provider", -1);
var _hoisted_17 = { class: "my-2 p-2 bg-[#eeeeff]" };
var _hoisted_18 = /* @__PURE__ */ createBaseVNode("div", null, "Category", -1);
var _hoisted_19 = ["value"];
var _hoisted_20 = ["value"];
var _hoisted_21 = /* @__PURE__ */ createBaseVNode("h2", null, "Account", -1);
var _hoisted_22 = { class: "my-2 p-2 bg-[#eeeeff]" };
var _hoisted_23 = /* @__PURE__ */ createBaseVNode("div", null, "Account Number: ", -1);
var _hoisted_24 = /* @__PURE__ */ createBaseVNode("div", null, "Account Name: ", -1);
var _hoisted_25 = /* @__PURE__ */ createBaseVNode("div", null, "Match existing account", -1);
var _hoisted_26 = /* @__PURE__ */ createBaseVNode("div", null, [/* @__PURE__ */ createBaseVNode("button", null, "Add New Account")], -1);
var _hoisted_27 = /* @__PURE__ */ createBaseVNode("div", null, "Bill Data: ", -1);
var _hoisted_28 = /* @__PURE__ */ createBaseVNode("div", null, "Amount: ", -1);
var _hoisted_29 = { key: 1 };
//#endregion
//#region src/pages/ReviewBills.vue
var ReviewBills_default = /* @__PURE__ */ defineComponent({
	__name: "ReviewBills",
	setup(__props) {
		const s = glib.vue.reactive({
			fids: [],
			rep: {},
			showUnitAdded: false,
			ucatproviders: [],
			uproviders: [],
			rt: runtime
		});
		glib.vue.onMounted(async () => {
			loader("/api/public/providers", {}, (rep) => {
				s.ucatproviders = [];
				rep.data.forEach((e) => {
					s.ucatproviders.push({
						ucat: e.ucat,
						uproviders: e.providers
					});
				});
			});
			try {
				let json = "" + sessionStorage.getItem("fids");
				s.fids = JSON.parse(json);
			} catch (e) {}
			sessionStorage.setItem("fids", JSON.stringify([]));
			loader("/api/eu/review-bill-files", { fids: s.fids }, (rep) => {
				s.rep = rep;
				onChangeCat();
			});
		});
		const onClickNewUnit = () => {
			loader("/api/eu/my-units", {
				data: {
					addr: s.rep.data.bill.p.ShownAddr,
					town: s.rep.data.bill.p.ShownTown,
					state: s.rep.data.bill.p.ShownState,
					zip: s.rep.data.bill.p.ShownZip
				},
				act: "create"
			}, (rep) => {
				s.showUnitAdded = true;
			});
		};
		const unit__key = (unit) => {
			return unit.id;
		};
		const unit__text = (unit) => {
			return unit.p.Address + ", " + unit.p.Town + ", " + unit.p.State + unit.p.Zip;
		};
		const onSelectUnit = (unit) => {
			s.rep.data.bill.id = unit.id;
			s.rep.data.bill.p.ShownAddr = unit.p.Address;
			s.rep.data.bill.p.ShownTown = unit.p.Town;
			s.rep.data.bill.p.ShownState = unit.p.State;
			s.rep.data.bill.p.ShownZip = unit.p.Zip;
		};
		const onChangeCat = () => {
			let found = s.ucatproviders.find((e) => e.ucat.id == s.rep.data.bill.p.Cat);
			if (found) s.uproviders = found.uproviders;
			else s.uproviders = [];
		};
		const confirm = () => {
			loader("/api/eu/submit-bill", { data: s.rep.data }, (rep) => {
				router.push("/");
			});
		};
		return (_ctx, _cache) => {
			return openBlock(), createElementBlock(Fragment, null, [
				_hoisted_1$4,
				(openBlock(true), createElementBlock(Fragment, null, renderList(unref(s).fids, (fid) => {
					return openBlock(), createElementBlock("div", null, [createBaseVNode("div", _hoisted_2$4, [createBaseVNode("img", { src: "/thumbnail/" + fid }, null, 8, _hoisted_3$3)])]);
				}), 256)),
				unref(s).rep.Er == "OK" ? (openBlock(), createElementBlock("div", _hoisted_4$3, [
					unref(s).rep.Ex != "" ? (openBlock(), createElementBlock("div", _hoisted_5$3, [_hoisted_6$2, createBaseVNode("p", null, toDisplayString(unref(s).rep.Ex), 1)])) : createCommentVNode("", true),
					_hoisted_7,
					createBaseVNode("div", _hoisted_8, [
						_hoisted_9,
						createBaseVNode("div", null, [withDirectives(createBaseVNode("input", { "onUpdate:modelValue": _cache[0] || (_cache[0] = ($event) => unref(s).rep.data.bill.p.ShownAddr = $event) }, null, 512), [[vModelText, unref(s).rep.data.bill.p.ShownAddr]])]),
						_hoisted_10,
						createBaseVNode("div", null, [withDirectives(createBaseVNode("input", { "onUpdate:modelValue": _cache[1] || (_cache[1] = ($event) => unref(s).rep.data.bill.p.ShownTown = $event) }, null, 512), [[vModelText, unref(s).rep.data.bill.p.ShownTown]])]),
						_hoisted_11,
						createVNode(StateLocator_default, {
							modelValue: unref(s).rep.data.bill.p.ShownState,
							"onUpdate:modelValue": _cache[2] || (_cache[2] = ($event) => unref(s).rep.data.bill.p.ShownState = $event)
						}, null, 8, ["modelValue"]),
						_hoisted_12,
						createBaseVNode("div", null, [withDirectives(createBaseVNode("input", { "onUpdate:modelValue": _cache[3] || (_cache[3] = ($event) => unref(s).rep.data.bill.p.ShownZip = $event) }, null, 512), [[vModelText, unref(s).rep.data.bill.p.ShownZip]])]),
						_hoisted_13,
						createBaseVNode("div", null, [createVNode(SearchField_default, {
							api: "/api/eu/my-units",
							item__key: unit__key,
							item__text: unit__text,
							onSelect: onSelectUnit
						})]),
						createBaseVNode("div", _hoisted_14, [createBaseVNode("button", { onClick: onClickNewUnit }, "Add as a New Unit"), unref(s).showUnitAdded ? (openBlock(), createElementBlock("div", _hoisted_15, "New Unit Added")) : createCommentVNode("", true)])
					]),
					_hoisted_16,
					createBaseVNode("div", _hoisted_17, [
						_hoisted_18,
						createBaseVNode("div", null, [withDirectives(createBaseVNode("select", {
							onChange: onChangeCat,
							"onUpdate:modelValue": _cache[4] || (_cache[4] = ($event) => unref(s).rep.data.bill.p.Cat = $event)
						}, [(openBlock(true), createElementBlock(Fragment, null, renderList(unref(s).ucatproviders, (item) => {
							return openBlock(), createElementBlock("option", { value: item.ucat.id }, toDisplayString(item.ucat.p.Caption), 9, _hoisted_19);
						}), 256))], 544), [[vModelSelect, unref(s).rep.data.bill.p.Cat]])]),
						createBaseVNode("div", null, "Provider: " + toDisplayString(unref(s).rep.data.bill.p.ShownProvider), 1),
						createBaseVNode("div", null, [withDirectives(createBaseVNode("select", { "onUpdate:modelValue": _cache[5] || (_cache[5] = ($event) => unref(s).rep.data.bill.p.Provider = $event) }, [(openBlock(true), createElementBlock(Fragment, null, renderList(unref(s).uproviders, (item) => {
							return openBlock(), createElementBlock("option", { value: item.id }, toDisplayString(item.p.Caption), 9, _hoisted_20);
						}), 256))], 512), [[vModelSelect, unref(s).rep.data.bill.p.Provider]])])
					]),
					_hoisted_21,
					createBaseVNode("div", _hoisted_22, [
						_hoisted_23,
						createBaseVNode("div", null, [withDirectives(createBaseVNode("input", { "onUpdate:modelValue": _cache[6] || (_cache[6] = ($event) => unref(s).rep.data.bill.p.ShownAcctNum = $event) }, null, 512), [[vModelText, unref(s).rep.data.bill.p.ShownAcctNum]])]),
						_hoisted_24,
						createBaseVNode("div", null, [withDirectives(createBaseVNode("input", { "onUpdate:modelValue": _cache[7] || (_cache[7] = ($event) => unref(s).rep.data.bill.p.ShownAcctName = $event) }, null, 512), [[vModelText, unref(s).rep.data.bill.p.ShownAcctName]])]),
						_hoisted_25,
						createBaseVNode("div", null, [createVNode(SearchField_default)]),
						_hoisted_26
					]),
					_hoisted_27,
					createBaseVNode("div", null, [withDirectives(createBaseVNode("input", { "onUpdate:modelValue": _cache[8] || (_cache[8] = ($event) => unref(s).rep.data.bill.p.BillDate = $event) }, null, 512), [[vModelText, unref(s).rep.data.bill.p.BillDate]])]),
					_hoisted_28,
					createBaseVNode("div", null, [withDirectives(createBaseVNode("input", { "onUpdate:modelValue": _cache[9] || (_cache[9] = ($event) => unref(s).rep.data.bill.p.Amt = $event) }, null, 512), [[vModelText, unref(s).rep.data.bill.p.Amt]])]),
					createBaseVNode("div", { class: "flex" }, [createBaseVNode("button", { onClick: confirm }, "Confirm"), createTextVNode(" the details and submit to our professional team. ")])
				])) : (openBlock(), createElementBlock("div", _hoisted_29, "AI processing ... 20 seconds expected"))
			], 64);
		};
	}
});
//#endregion
//#region src/pages/HomeCustomer.vue?vue&type=script&setup=true&lang.ts
var _hoisted_1$3 = /* @__PURE__ */ createBaseVNode("div", { class: "card" }, [/* @__PURE__ */ createBaseVNode("div", null, "Welcome"), /* @__PURE__ */ createBaseVNode("div", null, "https://whatsyourideal.com/")], -1);
var _hoisted_2$3 = { class: "mt-[20px] card" };
//#endregion
//#region src/pages/HomeCustomer.vue
var HomeCustomer_default = /* @__PURE__ */ defineComponent({
	__name: "HomeCustomer",
	setup(__props) {
		const s = glib.vue.reactive({
			providers: [],
			rt: runtime
		});
		glib.vue.onMounted(async () => {
			loader("/api/public/providers", {}, (rep) => {
				s.providers = [];
				rep.data.forEach((e) => {
					let ucat = e.ucat;
					let providers = [];
					e.providers.forEach((p) => {
						providers.push(p.p.Caption);
					});
					s.providers.push({
						ucat: ucat.p.Caption,
						uproviders: providers
					});
				});
			});
		});
		return (_ctx, _cache) => {
			return openBlock(), createElementBlock(Fragment, null, [_hoisted_1$3, createBaseVNode("div", _hoisted_2$3, [(openBlock(true), createElementBlock(Fragment, null, renderList(unref(s).providers, (item, index) => {
				return openBlock(), createElementBlock("div", null, [createBaseVNode("div", null, [createBaseVNode("b", null, toDisplayString(item.ucat), 1), (openBlock(true), createElementBlock(Fragment, null, renderList(item.uproviders, (ii) => {
					return openBlock(), createElementBlock("span", null, " | " + toDisplayString(ii), 1);
				}), 256))])]);
			}), 256))])], 64);
		};
	}
});
//#endregion
//#region src/pages/Admin.vue?vue&type=script&setup=true&lang.ts
var _hoisted_1$2 = { class: "flex justify-center" };
var _hoisted_2$2 = { class: "hor-range" };
var _hoisted_3$2 = { class: "card" };
var _hoisted_4$2 = /* @__PURE__ */ createBaseVNode("div", { class: "card-caption" }, "Users", -1);
var _hoisted_5$2 = /* @__PURE__ */ createBaseVNode("div", { class: "flex justify-center" }, [/* @__PURE__ */ createBaseVNode("div", { class: "hor-range" })], -1);
//#endregion
//#region src/pages/Admin.vue
var Admin_default = /* @__PURE__ */ defineComponent({
	__name: "Admin",
	setup(__props) {
		const s = glib.vue.reactive({
			users: [],
			rt: runtime
		});
		const user__key = (eu) => {
			return eu.id;
		};
		const user__text = (eu) => {
			return eu.p.Caption + " " + eu.p.Username + " " + eu.p.Email;
		};
		const onSelectUser = (eu) => {};
		glib.vue.onMounted(async () => {
			loader("/api/admin/users", { act: "ls" }, (rep) => {
				s.users = rep.data;
			});
		});
		return (_ctx, _cache) => {
			return openBlock(), createElementBlock(Fragment, null, [createBaseVNode("div", _hoisted_1$2, [createBaseVNode("div", _hoisted_2$2, [createBaseVNode("div", _hoisted_3$2, [
				_hoisted_4$2,
				createBaseVNode("div", null, [createVNode(SearchField_default, {
					api: "/api/admin/users",
					item__key: user__key,
					item__text: user__text,
					onSelect: onSelectUser
				})]),
				(openBlock(true), createElementBlock(Fragment, null, renderList(unref(s).users, (i) => {
					return openBlock(), createElementBlock("div", null, toDisplayString(i.p.Email), 1);
				}), 256))
			])])]), _hoisted_5$2], 64);
		};
	}
});
//#endregion
//#region src/lib/mod/route.ts
var route_exports = /* @__PURE__ */ __exportAll({
	incomingRoute: () => incomingRoute,
	navigate: () => navigate,
	router: () => router
});
var routes = [
	{
		path: "/",
		component: HomeCustomer_default
	},
	{
		path: "/UploadBills",
		component: UploadBills_default
	},
	{
		path: "/ReviewBills",
		component: ReviewBills_default
	},
	{
		path: "/admin",
		component: Admin_default
	}
];
var router = createRouter({
	history: createMemoryHistory(),
	routes
});
var navigate = (href, name, id) => {
	let url = href;
	if (url.indexOf("/zh/") > 0) {
		runtime.lang = "zh";
		localStorage.setItem("runtime.lang", runtime.lang);
		url = url.replace("/zh/", "/");
	}
	if (url.indexOf("/en/") > 0) {
		runtime.lang = "en";
		localStorage.setItem("runtime.lang", runtime.lang);
		url = url.replace("/en/", "/");
	}
	window.location.href = url;
	if (id != 0) router.push({
		name,
		params: { id }
	});
	else router.push(name);
};
var pages = [];
var incomingRoute = () => {
	let path = window.location.pathname;
	let hit = false;
	pages.forEach((page) => {
		let pattern = "/" + page + "/";
		if (path.startsWith(pattern)) {
			hit = true;
			let id = path.substring(pattern.length);
			router.push({
				name: page,
				params: { id }
			});
		}
	});
	if (hit == false) if (path.startsWith("/admin")) router.push("/admin");
	else router.push("/");
};
//#endregion
//#region src/lib/mod/panel.ts
var panel_exports = /* @__PURE__ */ __exportAll({ tglPanel: () => tglPanel });
var tglPanel = () => {
	globalThis.panelrt.showpanel = !globalThis.panelrt.showpanel;
};
//#endregion
//#region src/lib/store/host.ts
var host_exports = /* @__PURE__ */ __exportAll({
	checkDomain: () => checkDomain,
	initHost: () => initHost
});
var checkDomain = (domain) => {
	return [domain].includes(window.location.hostname);
};
var initHost = () => {
	const hostname = window.location.hostname;
	const host = {
		hostname,
		api: `${window.location.protocol}//${hostname}`,
		wsurl: `wss://${hostname}/ws/`,
		discordAPPID: "1254790111913181274",
		discordRedirect: `${window.location.protocol}//${window.location.host}/redirect/DISCORD`
	};
	switch (host.hostname) {
		case "localhost":
			host.hostname = "localhost";
			host.api = "https://localhost";
			host.wsurl = "wss://localhost/";
			break;
		case "127.0.0.1":
			host.hostname = "127.0.0.1";
			host.api = "http://localhost";
			host.wsurl = "wss://localhost/";
			break;
	}
	console.log("host.hostname: " + host.hostname);
	console.log("host.api: " + host.api);
	console.log("host.wsurl: " + host.wsurl);
	return host;
};
//#endregion
//#region src/lib/store/init.ts
var wsOnOpen = (runtime) => (event) => {
	console.log("WebSocket connected");
};
var wsOnClose = (runtime) => (event) => {
	console.log("WebSocket closed");
};
var wsOnError = (runtime) => (event) => {
	console.log(event);
};
var wsOnMsg = (runtime) => (event) => {
	let msg = event.data;
	switch (msg.e) {
		case MsgEnum.ApiResponse:
			console.log(msg.val);
			break;
	}
};
var initRuntime = (runtime) => {
	runtime.host = initHost();
	let ws = new WebSocket(runtime.host.wsurl);
	ws.onopen = wsOnOpen(runtime);
	ws.onclose = wsOnClose(runtime);
	ws.onerror = wsOnError(runtime);
	ws.onmessage = wsOnMsg(runtime);
	runtime.wsctx.ws = ws;
};
//#endregion
//#region src/lib/store/runtime.ts
var runtime_exports = /* @__PURE__ */ __exportAll({
	createGlobalWatcher: () => createGlobalWatcher,
	getRT: () => getRT,
	loadLS: () => loadLS,
	prepRuntime: () => prepRuntime,
	prstLS: () => prstLS,
	setNested: () => setNested,
	setRT: () => setRT
});
var loadLS = (key, defaultv = "{}") => {
	const v = window.localStorage.getItem(key);
	if (v != void 0) try {
		return JSON.parse(v);
	} catch {
		if (v) return v;
		else return defaultv;
	}
	return defaultv;
};
var prstLS = (key, value) => {
	window.localStorage.setItem(key, JSON.stringify(value));
};
var initWebSocketMeta = () => {
	return {
		ws: {},
		ping: null,
		autoping: true,
		pinginterval: 7e3,
		sent: 0,
		sentsize: 0,
		rec: 0,
		recsize: 0
	};
};
var prepRuntime = () => {
	let runtime = {
		host: {},
		wsctx: initWebSocketMeta(),
		router: glib.route.router,
		session: loadLS("session", ""),
		user: {},
		data: ClientRuntime_empty()
	};
	initRuntime(runtime);
	return runtime;
};
var getRT = (key, obj = runtime) => {
	return key.split(".").reduce((acc, curr) => acc?.[curr], obj);
};
var setNested = (key, value, f_map = (value) => {
	return value;
}, obj = runtime) => {
	const keys = key.split(".");
	const lastKey = keys.pop();
	if (!lastKey) return;
	const parent = keys.reduce((acc, curr) => acc?.[curr] ?? (acc[curr] = {}), obj);
	parent[lastKey] = f_map(value);
};
var setRT = setNested;
var createGlobalWatcher = () => {
	const createwatch = (rtkeys) => {
		for (const rtkey of rtkeys);
	};
	createwatch(["session", "devmode"]);
};
//#endregion
//#region src/lib/glib.ts
var glib = {
	vue: vue_runtime_esm_bundler_exports,
	check: check_exports,
	ws: ws_exports,
	bin: bin_exports,
	markdown: markdown_exports,
	g: graphics_exports,
	misc: misc_exports,
	auth: auth_exports,
	notify: notify_exports,
	route: route_exports,
	panel: panel_exports,
	host: host_exports,
	runtime: runtime_exports,
	Mor: { studio: {
		...CustomMor_exports,
		...OrmMor_exports
	} },
	post,
	get,
	send: trySend,
	setRT,
	getRT,
	sleep: sleep$1
};
//#endregion
//#region node_modules/@clerk/shared/dist/runtime/clerkRuntimeError-DqAmLuLY.mjs
/**
* Creates a type guard function for any error class.
* The returned function can be called as a standalone function or as a method on an error object.
*
* @example
* ```typescript
* class MyError extends Error {}
* const isMyError = createErrorTypeGuard(MyError);
*
* // As a standalone function
* if (isMyError(error)) { ... }
*
* // As a method (when attached to error object)
* if (error.isMyError()) { ... }
* ```
*/
function createErrorTypeGuard(ErrorClass) {
	function typeGuard(error) {
		const target = error ?? this;
		if (!target) throw new TypeError(`${ErrorClass.kind || ErrorClass.name} type guard requires an error object`);
		if (ErrorClass.kind && typeof target === "object" && target !== null && "constructor" in target) {
			if (target.constructor?.kind === ErrorClass.kind) return true;
		}
		return target instanceof ErrorClass;
	}
	return typeGuard;
}
var ClerkError = class ClerkError extends Error {
	static kind = "ClerkError";
	clerkError = true;
	code;
	longMessage;
	docsUrl;
	cause;
	get name() {
		return this.constructor.name;
	}
	constructor(opts) {
		super(new.target.formatMessage(new.target.kind, opts.message, opts.code, opts.docsUrl), { cause: opts.cause });
		Object.setPrototypeOf(this, ClerkError.prototype);
		this.code = opts.code;
		this.docsUrl = opts.docsUrl;
		this.longMessage = opts.longMessage;
		this.cause = opts.cause;
	}
	toString() {
		return `[${this.name}]\nMessage:${this.message}`;
	}
	static formatMessage(name, msg, code, docsUrl) {
		const prefix = "Clerk:";
		const regex = new RegExp(prefix.replace(" ", "\\s*"), "i");
		msg = msg.replace(regex, "");
		msg = `${prefix} ${msg.trim()}\n\n(code="${code}")\n\n`;
		if (docsUrl) msg += `\n\nDocs: ${docsUrl}`;
		return msg;
	}
};
/**
* Custom error class for representing Clerk runtime errors.
*
* @class ClerkRuntimeError
*
* @example
*   throw new ClerkRuntimeError('An error occurred', { code: 'password_invalid' });
*/
var ClerkRuntimeError = class ClerkRuntimeError extends ClerkError {
	static kind = "ClerkRuntimeError";
	/**
	* @deprecated Use `clerkError` property instead. This property is maintained for backward compatibility.
	*/
	clerkRuntimeError = true;
	constructor(message, options) {
		super({
			...options,
			message
		});
		Object.setPrototypeOf(this, ClerkRuntimeError.prototype);
	}
};
createErrorTypeGuard(ClerkRuntimeError);
//#endregion
//#region node_modules/@clerk/shared/dist/runtime/error-D-ayZ5nL.mjs
/**
* This error contains the specific error message, code, and any additional metadata that was returned by the Clerk API.
*/
var ClerkAPIError = class {
	static kind = "ClerkAPIError";
	code;
	message;
	longMessage;
	meta;
	constructor(json) {
		const parsedError = {
			code: json.code,
			message: json.message,
			longMessage: json.long_message,
			meta: {
				paramName: json.meta?.param_name,
				sessionId: json.meta?.session_id,
				emailAddresses: json.meta?.email_addresses,
				identifiers: json.meta?.identifiers,
				zxcvbn: json.meta?.zxcvbn,
				plan: json.meta?.plan,
				isPlanUpgradePossible: json.meta?.is_plan_upgrade_possible
			}
		};
		this.code = parsedError.code;
		this.message = parsedError.message;
		this.longMessage = parsedError.longMessage;
		this.meta = parsedError.meta;
	}
};
createErrorTypeGuard(ClerkAPIError);
createErrorTypeGuard(class ClerkAPIResponseError extends ClerkError {
	static kind = "ClerkAPIResponseError";
	status;
	clerkTraceId;
	retryAfter;
	errors;
	constructor(message, options) {
		const { data: errorsJson, status, clerkTraceId, retryAfter } = options;
		super({
			...options,
			message,
			code: "api_response_error"
		});
		Object.setPrototypeOf(this, ClerkAPIResponseError.prototype);
		this.status = status;
		this.clerkTraceId = clerkTraceId;
		this.retryAfter = retryAfter;
		this.errors = (errorsJson || []).map((e) => new ClerkAPIError(e));
	}
	toString() {
		let message = `[${this.name}]\nMessage:${this.message}\nStatus:${this.status}\nSerialized errors: ${this.errors.map((e) => JSON.stringify(e))}`;
		if (this.clerkTraceId) message += `\nClerk Trace ID: ${this.clerkTraceId}`;
		return message;
	}
	static formatMessage(name, msg, _, __) {
		return msg;
	}
});
var DefaultMessages = Object.freeze({
	InvalidProxyUrlErrorMessage: `The proxyUrl passed to Clerk is invalid. The expected value for proxyUrl is an absolute URL or a relative path with a leading '/'. (key={{url}})`,
	InvalidPublishableKeyErrorMessage: `The publishableKey passed to Clerk is invalid. You can get your Publishable key at https://dashboard.clerk.com/last-active?path=api-keys. (key={{key}})`,
	MissingPublishableKeyErrorMessage: `Missing publishableKey. You can get your key at https://dashboard.clerk.com/last-active?path=api-keys.`,
	MissingSecretKeyErrorMessage: `Missing secretKey. You can get your key at https://dashboard.clerk.com/last-active?path=api-keys.`,
	MissingClerkProvider: `{{source}} can only be used within the <ClerkProvider /> component. Learn more: https://clerk.com/docs/components/clerk-provider`
});
/**
* Builds an error thrower.
*
* @internal
*/
function buildErrorThrower({ packageName, customMessages }) {
	let pkg = packageName;
	/**
	* Builds a message from a raw message and replacements.
	*
	* @internal
	*/
	function buildMessage(rawMessage, replacements) {
		if (!replacements) return `${pkg}: ${rawMessage}`;
		let msg = rawMessage;
		const matches = rawMessage.matchAll(/{{([a-zA-Z0-9-_]+)}}/g);
		for (const match of matches) {
			const replacement = (replacements[match[1]] || "").toString();
			msg = msg.replace(`{{${match[1]}}}`, replacement);
		}
		return `${pkg}: ${msg}`;
	}
	const messages = {
		...DefaultMessages,
		...customMessages
	};
	return {
		setPackageName({ packageName: packageName$1 }) {
			if (typeof packageName$1 === "string") pkg = packageName$1;
			return this;
		},
		setMessages({ customMessages: customMessages$1 }) {
			Object.assign(messages, customMessages$1 || {});
			return this;
		},
		throwInvalidPublishableKeyError(params) {
			throw new Error(buildMessage(messages.InvalidPublishableKeyErrorMessage, params));
		},
		throwInvalidProxyUrl(params) {
			throw new Error(buildMessage(messages.InvalidProxyUrlErrorMessage, params));
		},
		throwMissingPublishableKeyError() {
			throw new Error(buildMessage(messages.MissingPublishableKeyErrorMessage));
		},
		throwMissingSecretKeyError() {
			throw new Error(buildMessage(messages.MissingSecretKeyErrorMessage));
		},
		throwMissingClerkProviderError(params) {
			throw new Error(buildMessage(messages.MissingClerkProvider, params));
		},
		throw(message) {
			throw new Error(buildMessage(message));
		}
	};
}
//#endregion
//#region node_modules/@clerk/vue/dist/chunk-B47IFXQ7.js
var errorThrower$1 = buildErrorThrower({ packageName: "@clerk/vue" });
function setErrorThrowerOptions(options) {
	errorThrower$1.setMessages(options).setPackageName(options);
}
var multipleChildrenInButtonComponent = (name) => `You've passed multiple children components to <${name}/>. You can only pass a single child component or text.`;
var invalidStateError = "Invalid state. Feel free to submit a bug or reach out to support here: https://clerk.com/support";
var userButtonMenuActionRenderedError = "<UserButton.Action /> component needs to be a direct child of `<UserButton.MenuItems />`.";
var userButtonMenuLinkRenderedError = "<UserButton.Link /> component needs to be a direct child of `<UserButton.MenuItems />`.";
var userButtonMenuItemLinkWrongProps = "Missing requirements. <UserButton.Link /> component requires props: href, label and slots: labelIcon.";
var userButtonMenuItemActionWrongProps = "Missing requirements. <UserButton.Action /> component requires props: label and slots: labelIcon.";
var userButtonMenuItemsRenderedError = "<UserButton.MenuItems /> component needs to be a direct child of `<UserButton />`.";
var customPageWrongProps = (componentName) => `Missing requirements. <${componentName}.Page /> component requires props: url, label and slots: labelIcon and a default slot for page content`;
var customLinkWrongProps = (componentName) => `Missing requirements. <${componentName}.Link /> component requires the following props: url, label and slots: labelIcon.`;
var userProfilePageRenderedError = "<UserProfile.Page /> component needs to be a direct child of `<UserProfile />` or `<UserButton />`.";
var userProfileLinkRenderedError = "<UserProfile.Link /> component needs to be a direct child of `<UserProfile />` or `<UserButton />`.";
var organizationProfilePageRenderedError = "<OrganizationProfile.Page /> component needs to be a direct child of `<OrganizationProfile />` or `<OrganizationSwitcher />`.";
var organizationProfileLinkRenderedError = "<OrganizationProfile.Link /> component needs to be a direct child of `<OrganizationProfile />` or `<OrganizationSwitcher />`.";
//#endregion
//#region node_modules/@clerk/shared/dist/runtime/authorization-Un7v7f6J.mjs
var TYPES_TO_OBJECTS = {
	strict_mfa: {
		afterMinutes: 10,
		level: "multi_factor"
	},
	strict: {
		afterMinutes: 10,
		level: "second_factor"
	},
	moderate: {
		afterMinutes: 60,
		level: "second_factor"
	},
	lax: {
		afterMinutes: 1440,
		level: "second_factor"
	}
};
var ALLOWED_LEVELS = new Set([
	"first_factor",
	"second_factor",
	"multi_factor"
]);
var ALLOWED_TYPES = new Set([
	"strict_mfa",
	"strict",
	"moderate",
	"lax"
]);
var ORG_SCOPES = new Set([
	"o",
	"org",
	"organization"
]);
var USER_SCOPES = new Set(["u", "user"]);
var isValidMaxAge = (maxAge) => typeof maxAge === "number" && maxAge > 0;
var isValidLevel = (level) => ALLOWED_LEVELS.has(level);
var isValidVerificationType = (type) => ALLOWED_TYPES.has(type);
var prefixWithOrg = (value) => value.replace(/^(org:)*/, "org:");
/**
* Checks if a user has the required organization-level authorization.
* Verifies if the user has the specified role or permission within their organization.
*
* @returns null, if unable to determine due to missing data or unspecified role/permission.
*/
var checkOrgAuthorization = (params, options) => {
	const { orgId, orgRole, orgPermissions } = options;
	if (!params.role && !params.permission) return null;
	if (!orgId || !orgRole || !orgPermissions) return null;
	if (params.permission) return orgPermissions.includes(prefixWithOrg(params.permission));
	if (params.role) return prefixWithOrg(orgRole) === prefixWithOrg(params.role);
	return null;
};
var checkForFeatureOrPlan = (claim, featureOrPlan) => {
	const { org: orgFeatures, user: userFeatures } = splitByScope(claim);
	const [rawScope, rawId] = featureOrPlan.split(":");
	const hasExplicitScope = rawId !== void 0;
	const scope = rawScope;
	const id = rawId || rawScope;
	if (hasExplicitScope && !ORG_SCOPES.has(scope) && !USER_SCOPES.has(scope)) throw new Error(`Invalid scope: ${scope}`);
	if (hasExplicitScope) {
		if (ORG_SCOPES.has(scope)) return orgFeatures.includes(id);
		if (USER_SCOPES.has(scope)) return userFeatures.includes(id);
	}
	return [...orgFeatures, ...userFeatures].includes(id);
};
var checkBillingAuthorization = (params, options) => {
	const { features, plans } = options;
	if (params.feature && features) return checkForFeatureOrPlan(features, params.feature);
	if (params.plan && plans) return checkForFeatureOrPlan(plans, params.plan);
	return null;
};
var splitByScope = (fea) => {
	const org = [];
	const user = [];
	if (!fea) return {
		org,
		user
	};
	const parts = fea.split(",");
	for (let i = 0; i < parts.length; i++) {
		const part = parts[i].trim();
		const colonIndex = part.indexOf(":");
		if (colonIndex === -1) throw new Error(`Invalid claim element (missing colon): ${part}`);
		const scope = part.slice(0, colonIndex);
		const value = part.slice(colonIndex + 1);
		if (scope === "o") org.push(value);
		else if (scope === "u") user.push(value);
		else if (scope === "ou" || scope === "uo") {
			org.push(value);
			user.push(value);
		}
	}
	return {
		org,
		user
	};
};
var validateReverificationConfig = (config) => {
	if (!config) return false;
	const convertConfigToObject = (config$1) => {
		if (typeof config$1 === "string") return TYPES_TO_OBJECTS[config$1];
		return config$1;
	};
	const isValidStringValue = typeof config === "string" && isValidVerificationType(config);
	const isValidObjectValue = typeof config === "object" && isValidLevel(config.level) && isValidMaxAge(config.afterMinutes);
	if (isValidStringValue || isValidObjectValue) return convertConfigToObject.bind(null, config);
	return false;
};
/**
* Evaluates if the user meets re-verification authentication requirements.
* Compares the user's factor verification ages against the specified maxAge.
* Handles different verification levels (first factor, second factor, multi-factor).
*
* @returns null, if requirements or verification data are missing.
*/
var checkReverificationAuthorization = (params, { factorVerificationAge }) => {
	if (!params.reverification || !factorVerificationAge) return null;
	const isValidReverification = validateReverificationConfig(params.reverification);
	if (!isValidReverification) return null;
	const { level, afterMinutes } = isValidReverification();
	const [factor1Age, factor2Age] = factorVerificationAge;
	const isValidFactor1 = factor1Age !== -1 ? afterMinutes > factor1Age : null;
	const isValidFactor2 = factor2Age !== -1 ? afterMinutes > factor2Age : null;
	switch (level) {
		case "first_factor": return isValidFactor1;
		case "second_factor": return factor2Age !== -1 ? isValidFactor2 : isValidFactor1;
		case "multi_factor": return factor2Age === -1 ? isValidFactor1 : isValidFactor1 && isValidFactor2;
	}
};
/**
* Creates a function for comprehensive user authorization checks.
* Combines organization-level and reverification authentication checks.
* The returned function authorizes if both checks pass, or if at least one passes
* when the other is indeterminate. Fails if userId is missing.
*/
var createCheckAuthorization = (options) => {
	return (params) => {
		if (!options.userId) return false;
		const billingAuthorization = checkBillingAuthorization(params, options);
		const orgAuthorization = checkOrgAuthorization(params, options);
		const reverificationAuthorization = checkReverificationAuthorization(params, options);
		if ([billingAuthorization || orgAuthorization, reverificationAuthorization].some((a) => a === null)) return [billingAuthorization || orgAuthorization, reverificationAuthorization].some((a) => a === true);
		return [billingAuthorization || orgAuthorization, reverificationAuthorization].every((a) => a === true);
	};
};
/**
* Shared utility function that centralizes auth state resolution logic,
* preventing duplication across different packages.
*
* @internal
*/
var resolveAuthState = ({ authObject: { sessionId, sessionStatus, userId, actor, orgId, orgRole, orgSlug, signOut, getToken, has, sessionClaims }, options: { treatPendingAsSignedOut = true } }) => {
	if (sessionId === void 0 && userId === void 0) return {
		actor: void 0,
		getToken,
		has: () => false,
		isLoaded: false,
		isSignedIn: void 0,
		orgId: void 0,
		orgRole: void 0,
		orgSlug: void 0,
		sessionClaims: void 0,
		sessionId,
		signOut,
		userId
	};
	if (sessionId === null && userId === null) return {
		actor: null,
		getToken,
		has: () => false,
		isLoaded: true,
		isSignedIn: false,
		orgId: null,
		orgRole: null,
		orgSlug: null,
		sessionClaims: null,
		sessionId,
		signOut,
		userId
	};
	if (treatPendingAsSignedOut && sessionStatus === "pending") return {
		actor: null,
		getToken,
		has: () => false,
		isLoaded: true,
		isSignedIn: false,
		orgId: null,
		orgRole: null,
		orgSlug: null,
		sessionClaims: null,
		sessionId: null,
		signOut,
		userId: null
	};
	if (!!sessionId && !!sessionClaims && !!userId && !!orgId && !!orgRole) return {
		actor: actor || null,
		getToken,
		has,
		isLoaded: true,
		isSignedIn: true,
		orgId,
		orgRole,
		orgSlug: orgSlug || null,
		sessionClaims,
		sessionId,
		signOut,
		userId
	};
	if (!!sessionId && !!sessionClaims && !!userId && !orgId) return {
		actor: actor || null,
		getToken,
		has,
		isLoaded: true,
		isSignedIn: true,
		orgId: null,
		orgRole: null,
		orgSlug: null,
		sessionClaims,
		sessionId,
		signOut,
		userId
	};
};
//#endregion
//#region node_modules/@clerk/vue/dist/chunk-7D4GN6SK.js
var ClerkInjectionKey = Symbol("clerk");
var UserButtonInjectionKey = Symbol("UserButton");
var UserButtonMenuItemsInjectionKey = Symbol("UserButton.MenuItems");
var UserProfileInjectionKey = Symbol("UserProfile");
var OrganizationProfileInjectionKey = Symbol("OrganizationProfile");
var PortalInjectionKey = Symbol("Portal");
function useClerkContext(source) {
	const ctx = inject(ClerkInjectionKey);
	if (!ctx) return errorThrower$1.throw(`${source} can only be used when the Vue plugin is installed. Learn more: https://clerk.com/docs/reference/vue/clerk-plugin`);
	return ctx;
}
var useClerk = () => {
	const { clerk } = useClerkContext("useClerk");
	return clerk;
};
var normalizeWithDefaultValue = (slotContent, defaultValue) => {
	if (!slotContent) return h("button", defaultValue);
	if (slotContent[0].type === Text) return h("button", slotContent);
	return slotContent;
};
var assertSingleChild = (slotContent, name) => {
	if (Array.isArray(slotContent)) {
		if (slotContent.length > 1) return errorThrower$1.throw(multipleChildrenInButtonComponent(name));
		return slotContent[0];
	}
	return slotContent;
};
function toComputedRefs(objectRef) {
	const result = {};
	for (const key in objectRef.value) result[key] = computed(() => objectRef.value[key]);
	return result;
}
function clerkLoaded(clerk) {
	return new Promise((resolve) => {
		let unwatch;
		unwatch = watch(clerk, (value) => {
			if (value?.loaded) {
				resolve(value);
				unwatch?.();
			}
		}, { immediate: true });
	});
}
function createGetToken(clerk) {
	return async (options) => {
		const loadedClerk = await clerkLoaded(clerk);
		if (!loadedClerk.session) return null;
		return loadedClerk.session.getToken(options);
	};
}
function createSignOut(clerk) {
	return async (...args) => {
		return (await clerkLoaded(clerk)).signOut(...args);
	};
}
var useAuth = (options = {}) => {
	const { clerk, authCtx } = useClerkContext("useAuth");
	const getToken = createGetToken(clerk);
	const signOut = createSignOut(clerk);
	return toComputedRefs(computed(() => {
		const { userId, orgId, orgRole, orgPermissions, sessionClaims, factorVerificationAge } = authCtx.value;
		const has = createCheckAuthorization({
			userId,
			orgId,
			orgRole,
			orgPermissions,
			factorVerificationAge,
			features: sessionClaims?.fea || "",
			plans: sessionClaims?.pla || ""
		});
		const payload = resolveAuthState({
			authObject: {
				...authCtx.value,
				getToken,
				signOut,
				has
			},
			options: { treatPendingAsSignedOut: options.treatPendingAsSignedOut }
		});
		if (!payload) return errorThrower$1.throw(invalidStateError);
		return payload;
	}));
};
var export_helper_default = (sfc, props) => {
	const target = sfc.__vccOpts || sfc;
	for (const [key, val] of props) target[key] = val;
	return target;
};
//#endregion
//#region node_modules/@clerk/shared/dist/runtime/constants-Bta24VLk.mjs
var DEV_OR_STAGING_SUFFIXES = [
	".lcl.dev",
	".stg.dev",
	".lclstage.dev",
	".stgstage.dev",
	".dev.lclclerk.com",
	".stg.lclclerk.com",
	".accounts.lclclerk.com",
	"accountsstage.dev",
	"accounts.dev"
];
//#endregion
//#region node_modules/@clerk/shared/dist/runtime/isomorphicAtob-CoF80qYz.mjs
/**
* A function that decodes a string of data which has been encoded using base-64 encoding.
* Uses `atob` if available, otherwise uses `Buffer` from `globalThis`. If neither are available, returns the data as-is.
*/
var isomorphicAtob = (data) => {
	if (typeof atob !== "undefined" && typeof atob === "function") return atob(data);
	else if (typeof globalThis.Buffer !== "undefined") return globalThis.Buffer.from(data, "base64").toString();
	return data;
};
//#endregion
//#region node_modules/@clerk/shared/dist/runtime/keys-DuxzP8MU.mjs
/** Prefix used for production publishable keys */
var PUBLISHABLE_KEY_LIVE_PREFIX = "pk_live_";
/** Prefix used for development publishable keys */
var PUBLISHABLE_KEY_TEST_PREFIX = "pk_test_";
/**
* Validates that a decoded publishable key has the correct format.
* The decoded value should be a frontend API followed by exactly one '$' at the end.
*
* @param decoded - The decoded publishable key string to validate.
* @returns `true` if the decoded key has valid format, `false` otherwise.
*/
function isValidDecodedPublishableKey(decoded) {
	if (!decoded.endsWith("$")) return false;
	const withoutTrailing = decoded.slice(0, -1);
	if (withoutTrailing.includes("$")) return false;
	return withoutTrailing.includes(".");
}
/**
* Parses and validates a publishable key, extracting the frontend API and instance type.
*
* @param key - The publishable key to parse.
* @param options - Configuration options for parsing.
* @param options.fatal
* @param options.domain
* @param options.proxyUrl
* @param options.isSatellite
* @returns Parsed publishable key object with instanceType and frontendApi, or null if invalid.
*
* @throws {Error} When options.fatal is true and key is missing or invalid.
*/
function parsePublishableKey(key, options = {}) {
	key = key || "";
	if (!key || !isPublishableKey(key)) {
		if (options.fatal && !key) throw new Error("Publishable key is missing. Ensure that your publishable key is correctly configured. Double-check your environment configuration for your keys, or access them here: https://dashboard.clerk.com/last-active?path=api-keys");
		if (options.fatal && !isPublishableKey(key)) throw new Error("Publishable key not valid.");
		return null;
	}
	const instanceType = key.startsWith(PUBLISHABLE_KEY_LIVE_PREFIX) ? "production" : "development";
	let decodedFrontendApi;
	try {
		decodedFrontendApi = isomorphicAtob(key.split("_")[2]);
	} catch {
		if (options.fatal) throw new Error("Publishable key not valid: Failed to decode key.");
		return null;
	}
	if (!isValidDecodedPublishableKey(decodedFrontendApi)) {
		if (options.fatal) throw new Error("Publishable key not valid: Decoded key has invalid format.");
		return null;
	}
	let frontendApi = decodedFrontendApi.slice(0, -1);
	if (options.proxyUrl) frontendApi = options.proxyUrl;
	else if (instanceType !== "development" && options.domain && options.isSatellite) frontendApi = `clerk.${options.domain}`;
	return {
		instanceType,
		frontendApi
	};
}
/**
* Checks if the provided key is a valid publishable key.
*
* @param key - The key to be checked. Defaults to an empty string if not provided.
* @returns `true` if 'key' is a valid publishable key, `false` otherwise.
*/
function isPublishableKey(key = "") {
	try {
		if (!(key.startsWith(PUBLISHABLE_KEY_LIVE_PREFIX) || key.startsWith(PUBLISHABLE_KEY_TEST_PREFIX))) return false;
		const parts = key.split("_");
		if (parts.length !== 3) return false;
		const encodedPart = parts[2];
		if (!encodedPart) return false;
		return isValidDecodedPublishableKey(isomorphicAtob(encodedPart));
	} catch {
		return false;
	}
}
/**
* Creates a memoized cache for checking if URLs are development or staging environments.
* Uses a Map to cache results for better performance on repeated checks.
*
* @returns An object with an isDevOrStagingUrl method that checks if a URL is dev/staging.
*/
function createDevOrStagingUrlCache() {
	const devOrStagingUrlCache = /* @__PURE__ */ new Map();
	return { isDevOrStagingUrl: (url) => {
		if (!url) return false;
		const hostname = typeof url === "string" ? url : url.hostname;
		let res = devOrStagingUrlCache.get(hostname);
		if (res === void 0) {
			res = DEV_OR_STAGING_SUFFIXES.some((s) => hostname.endsWith(s));
			devOrStagingUrlCache.set(hostname, res);
		}
		return res;
	} };
}
//#endregion
//#region node_modules/@clerk/shared/dist/runtime/retry-DqRIhHV5.mjs
var defaultOptions = {
	initialDelay: 125,
	maxDelayBetweenRetries: 0,
	factor: 2,
	shouldRetry: (_, iteration) => iteration < 5,
	retryImmediately: false,
	jitter: true
};
var RETRY_IMMEDIATELY_DELAY = 100;
var sleep = async (ms) => new Promise((s) => setTimeout(s, ms));
var applyJitter = (delay, jitter) => {
	return jitter ? delay * (1 + Math.random()) : delay;
};
var createExponentialDelayAsyncFn = (opts) => {
	let timesCalled = 0;
	const calculateDelayInMs = () => {
		const constant = opts.initialDelay;
		const base = opts.factor;
		let delay = constant * Math.pow(base, timesCalled);
		delay = applyJitter(delay, opts.jitter);
		return Math.min(opts.maxDelayBetweenRetries || delay, delay);
	};
	return async () => {
		await sleep(calculateDelayInMs());
		timesCalled++;
	};
};
/**
* Retries a callback until it succeeds or the shouldRetry function returns false.
* See {@link RetryOptions} for the available options.
*/
var retry = async (callback, options = {}) => {
	let iterations = 0;
	const { shouldRetry, initialDelay, maxDelayBetweenRetries, factor, retryImmediately, jitter, onBeforeRetry } = {
		...defaultOptions,
		...options
	};
	const delay = createExponentialDelayAsyncFn({
		initialDelay,
		maxDelayBetweenRetries,
		factor,
		jitter
	});
	while (true) try {
		return await callback();
	} catch (e) {
		iterations++;
		if (!shouldRetry(e, iterations)) throw e;
		if (onBeforeRetry) await onBeforeRetry(iterations);
		if (retryImmediately && iterations === 1) await sleep(applyJitter(RETRY_IMMEDIATELY_DELAY, jitter));
		else await delay();
	}
};
//#endregion
//#region node_modules/@clerk/shared/dist/runtime/loadScript-UG_epen4.mjs
var NO_DOCUMENT_ERROR = "loadScript cannot be called when document does not exist";
var NO_SRC_ERROR = "loadScript cannot be called without a src";
/**
*
*/
async function loadScript(src = "", opts) {
	const { async, defer, beforeLoad, crossOrigin, nonce } = opts || {};
	const load = () => {
		return new Promise((resolve, reject) => {
			if (!src) reject(new Error(NO_SRC_ERROR));
			if (!document || !document.body) reject(new Error(NO_DOCUMENT_ERROR));
			const script = document.createElement("script");
			if (crossOrigin) script.setAttribute("crossorigin", crossOrigin);
			script.async = async || false;
			script.defer = defer || false;
			script.addEventListener("load", () => {
				script.remove();
				resolve(script);
			});
			script.addEventListener("error", (event) => {
				script.remove();
				reject(event.error ?? /* @__PURE__ */ new Error(`failed to load script: ${src}`));
			});
			script.src = src;
			script.nonce = nonce;
			beforeLoad?.(script);
			document.body.appendChild(script);
		});
	};
	return retry(load, { shouldRetry: (_, iterations) => {
		return iterations <= 5;
	} });
}
//#endregion
//#region node_modules/@clerk/shared/dist/runtime/proxy-BcfViKjn.mjs
/**
*
*/
function isValidProxyUrl(key) {
	if (!key) return true;
	return isHttpOrHttps(key) || isProxyUrlRelative(key);
}
/**
*
*/
function isHttpOrHttps(key) {
	return /^http(s)?:\/\//.test(key || "");
}
/**
*
*/
function isProxyUrlRelative(key) {
	return key.startsWith("/");
}
/**
*
*/
function proxyUrlToAbsoluteURL(url) {
	if (!url) return "";
	return isProxyUrlRelative(url) ? new URL(url, window.location.origin).toString() : url;
}
//#endregion
//#region node_modules/@clerk/shared/dist/runtime/url-C6gPMFx5.mjs
/**
*
*/
function addClerkPrefix(str) {
	if (!str) return "";
	let regex;
	if (str.match(/^(clerk\.)+\w*$/)) regex = /(clerk\.)*(?=clerk\.)/;
	else if (str.match(/\.clerk.accounts/)) return str;
	else regex = /^(clerk\.)*/gi;
	return `clerk.${str.replace(regex, "")}`;
}
//#endregion
//#region node_modules/@clerk/shared/dist/runtime/versionSelector-Cx1-K89P.mjs
/**
* This version selector is a bit complicated, so here is the flow:
* 1. Use the clerkJSVersion prop on the provider
* 2. Use the exact `@clerk/clerk-js` version if it is a `@snapshot` prerelease
* 3. Use the prerelease tag of `@clerk/clerk-js` or the packageVersion provided
* 4. Fallback to the major version of `@clerk/clerk-js` or the packageVersion provided
*
* @param clerkJSVersion - The optional clerkJSVersion prop on the provider
* @param packageVersion - The version of `@clerk/clerk-js` that will be used if an explicit version is not provided
* @returns The npm tag, version or major version to use
*/
var versionSelector = (clerkJSVersion, packageVersion = "6.3.2") => {
	if (clerkJSVersion) return clerkJSVersion;
	const prereleaseTag = getPrereleaseTag(packageVersion);
	if (prereleaseTag) {
		if (prereleaseTag === "snapshot") return packageVersion;
		return prereleaseTag;
	}
	return getMajorVersion(packageVersion);
};
var getPrereleaseTag = (packageVersion) => packageVersion.trim().replace(/^v/, "").match(/-(.+?)(\.|$)/)?.[1];
var getMajorVersion = (packageVersion) => packageVersion.trim().replace(/^v/, "").split(".")[0];
//#endregion
//#region node_modules/@clerk/shared/dist/runtime/loadClerkJsScript.mjs
var { isDevOrStagingUrl } = createDevOrStagingUrlCache();
var errorThrower = buildErrorThrower({ packageName: "@clerk/shared" });
/**
* Validates that window.Clerk exists and is properly initialized.
* This ensures we don't have false positives where the script loads but Clerk is malformed.
*
* @returns `true` if window.Clerk exists and has the expected structure with a load method.
*/
function isClerkGlobalProperlyLoaded(prop) {
	if (typeof window === "undefined" || !window[prop]) return false;
	return !!window[prop];
}
var isClerkProperlyLoaded = () => isClerkGlobalProperlyLoaded("Clerk");
var isClerkUIProperlyLoaded = () => isClerkGlobalProperlyLoaded("__internal_ClerkUICtor");
/**
* Checks if an existing script has a request error using Performance API.
*
* @param scriptUrl - The URL of the script to check.
* @returns True if the script has failed to load due to a network/HTTP error.
*/
function hasScriptRequestError(scriptUrl) {
	if (typeof window === "undefined" || !window.performance) return false;
	const entries = performance.getEntriesByName(scriptUrl, "resource");
	if (entries.length === 0) return false;
	const scriptEntry = entries[entries.length - 1];
	if (scriptEntry.transferSize === 0 && scriptEntry.decodedBodySize === 0) {
		if (scriptEntry.responseEnd === 0) return true;
		if (scriptEntry.responseEnd > 0 && scriptEntry.responseStart > 0) return true;
		if ("responseStatus" in scriptEntry) {
			if (scriptEntry.responseStatus >= 400) return true;
			if (scriptEntry.responseStatus === 0) return true;
		}
	}
	return false;
}
/**
* Hotloads the Clerk JS script with robust failure detection.
*
* Uses a timeout-based approach to ensure absolute certainty about load success/failure.
* If the script fails to load within the timeout period, or loads but doesn't create
* a proper Clerk instance, the promise rejects with an error.
*
* @param opts - The options used to build the Clerk JS script URL and load the script.
*               Must include a `publishableKey` if no existing script is found.
* @returns Promise that resolves with null if Clerk loads successfully, or rejects with an error.
*
* @example
* ```typescript
* try {
*   await loadClerkJsScript({ publishableKey: 'pk_test_...' });
*   console.log('Clerk loaded successfully');
* } catch (error) {
*   console.error('Failed to load Clerk:', error.message);
* }
* ```
*/
var loadClerkJSScript = async (opts) => {
	const timeout = opts?.scriptLoadTimeout ?? 15e3;
	const rejectWith = (error) => new ClerkRuntimeError("Failed to load Clerk JS" + (error?.message ? `, ${error.message}` : ""), {
		code: "failed_to_load_clerk_js",
		cause: error
	});
	if (isClerkProperlyLoaded()) return null;
	if (!opts?.publishableKey) {
		errorThrower.throwMissingPublishableKeyError();
		return null;
	}
	const scriptUrl = clerkJSScriptUrl(opts);
	const existingScript = document.querySelector("script[data-clerk-js-script]");
	if (existingScript) if (hasScriptRequestError(scriptUrl)) existingScript.remove();
	else try {
		await waitForPredicateWithTimeout(timeout, isClerkProperlyLoaded, rejectWith(), existingScript);
		return null;
	} catch {
		existingScript.remove();
	}
	const loadPromise = waitForPredicateWithTimeout(timeout, isClerkProperlyLoaded, rejectWith());
	loadScript(scriptUrl, {
		async: true,
		crossOrigin: "anonymous",
		nonce: opts.nonce,
		beforeLoad: applyAttributesToScript(buildClerkJSScriptAttributes(opts))
	}).catch((error) => {
		throw rejectWith(error);
	});
	return loadPromise;
};
var loadClerkUIScript = async (opts) => {
	const timeout = opts?.scriptLoadTimeout ?? 15e3;
	const rejectWith = (error) => new ClerkRuntimeError("Failed to load Clerk UI" + (error?.message ? `, ${error.message}` : ""), {
		code: "failed_to_load_clerk_ui",
		cause: error
	});
	if (isClerkUIProperlyLoaded()) return null;
	if (!opts?.publishableKey) {
		errorThrower.throwMissingPublishableKeyError();
		return null;
	}
	const scriptUrl = clerkUIScriptUrl(opts);
	const existingScript = document.querySelector("script[data-clerk-ui-script]");
	if (existingScript) if (hasScriptRequestError(scriptUrl)) existingScript.remove();
	else try {
		await waitForPredicateWithTimeout(timeout, isClerkUIProperlyLoaded, rejectWith(), existingScript);
		return null;
	} catch {
		existingScript.remove();
	}
	const loadPromise = waitForPredicateWithTimeout(timeout, isClerkUIProperlyLoaded, rejectWith());
	loadScript(scriptUrl, {
		async: true,
		crossOrigin: "anonymous",
		nonce: opts.nonce,
		beforeLoad: applyAttributesToScript(buildClerkUIScriptAttributes(opts))
	}).catch((error) => {
		throw rejectWith(error);
	});
	return loadPromise;
};
var clerkJSScriptUrl = (opts) => {
	const { __internal_clerkJSUrl, __internal_clerkJSVersion, proxyUrl, domain, publishableKey } = opts;
	if (__internal_clerkJSUrl) return __internal_clerkJSUrl;
	return `https://${buildScriptHost({
		publishableKey,
		proxyUrl,
		domain
	})}/npm/@clerk/clerk-js@${versionSelector(__internal_clerkJSVersion)}/dist/clerk.browser.js`;
};
var clerkUIScriptUrl = (opts) => {
	const { __internal_clerkUIUrl, __internal_clerkUIVersion, proxyUrl, domain, publishableKey } = opts;
	if (__internal_clerkUIUrl) return __internal_clerkUIUrl;
	return `https://${buildScriptHost({
		publishableKey,
		proxyUrl,
		domain
	})}/npm/@clerk/ui@${versionSelector(__internal_clerkUIVersion, "1.2.3")}/dist/ui.browser.js`;
};
var buildClerkJSScriptAttributes = (options) => {
	const obj = {};
	if (options.publishableKey) obj["data-clerk-publishable-key"] = options.publishableKey;
	if (options.proxyUrl) obj["data-clerk-proxy-url"] = options.proxyUrl;
	if (options.domain) obj["data-clerk-domain"] = options.domain;
	if (options.nonce) obj.nonce = options.nonce;
	return obj;
};
var buildClerkUIScriptAttributes = (options) => {
	return buildClerkJSScriptAttributes(options);
};
var applyAttributesToScript = (attributes) => (script) => {
	for (const attribute in attributes) script.setAttribute(attribute, attributes[attribute]);
};
var buildScriptHost = (opts) => {
	const { proxyUrl, domain, publishableKey } = opts;
	if (!!proxyUrl && isValidProxyUrl(proxyUrl)) return proxyUrlToAbsoluteURL(proxyUrl).replace(/http(s)?:\/\//, "");
	else if (domain && !isDevOrStagingUrl(parsePublishableKey(publishableKey)?.frontendApi || "")) return addClerkPrefix(domain);
	else return parsePublishableKey(publishableKey)?.frontendApi || "";
};
function waitForPredicateWithTimeout(timeoutMs, predicate, rejectWith, existingScript) {
	return new Promise((resolve, reject) => {
		let resolved = false;
		const cleanup = (timeoutId$1, pollInterval$1) => {
			clearTimeout(timeoutId$1);
			clearInterval(pollInterval$1);
		};
		existingScript?.addEventListener("error", () => {
			cleanup(timeoutId, pollInterval);
			reject(rejectWith);
		});
		const checkAndResolve = () => {
			if (resolved) return;
			if (predicate()) {
				resolved = true;
				cleanup(timeoutId, pollInterval);
				resolve(null);
			}
		};
		const handleTimeout = () => {
			if (resolved) return;
			resolved = true;
			cleanup(timeoutId, pollInterval);
			if (!predicate()) reject(rejectWith);
			else resolve(null);
		};
		const timeoutId = setTimeout(handleTimeout, timeoutMs);
		checkAndResolve();
		const pollInterval = setInterval(() => {
			if (resolved) {
				clearInterval(pollInterval);
				return;
			}
			checkAndResolve();
		}, 100);
	});
}
function setClerkJSLoadingErrorPackageName(packageName) {
	errorThrower.setPackageName({ packageName });
}
//#endregion
//#region node_modules/@clerk/shared/dist/runtime/runtimeEnvironment-D1yr0yUs.mjs
var isDevelopmentEnvironment = () => {
	try {
		return false;
	} catch {}
	return false;
};
//#endregion
//#region node_modules/@clerk/shared/dist/runtime/underscore-ClYSgvuy.mjs
/**
* Converts a string from snake_case to camelCase.
*/
function snakeToCamel(str) {
	return str ? str.replace(/([-_][a-z])/g, (match) => match.toUpperCase().replace(/-|_/, "")) : "";
}
/**
* Converts a string from camelCase to snake_case.
*/
function camelToSnake(str) {
	return str ? str.replace(/[A-Z]/g, (letter) => `_${letter.toLowerCase()}`) : "";
}
var createDeepObjectTransformer = (transform) => {
	const deepTransform = (obj) => {
		if (!obj) return obj;
		if (Array.isArray(obj)) return obj.map((el) => {
			if (typeof el === "object" || Array.isArray(el)) return deepTransform(el);
			return el;
		});
		const copy = { ...obj };
		const keys = Object.keys(copy);
		for (const oldName of keys) {
			const newName = transform(oldName.toString());
			if (newName !== oldName) {
				copy[newName] = copy[oldName];
				delete copy[oldName];
			}
			if (typeof copy[newName] === "object") copy[newName] = deepTransform(copy[newName]);
		}
		return copy;
	};
	return deepTransform;
};
createDeepObjectTransformer(camelToSnake);
createDeepObjectTransformer(snakeToCamel);
//#endregion
//#region node_modules/@clerk/shared/dist/runtime/utils-TXJdVJx7.mjs
var logErrorInDevMode = (message) => {
	if (isDevelopmentEnvironment()) console.error(`Clerk: ${message}`);
};
//#endregion
//#region node_modules/@clerk/shared/dist/runtime/browser-CMFCxUv7.mjs
/**
* Checks if the window object is defined. You can also use this to check if something is happening on the client side.
*
* @returns
*/
function inBrowser() {
	return typeof window !== "undefined";
}
new RegExp([
	"bot",
	"spider",
	"crawl",
	"APIs-Google",
	"AdsBot",
	"Googlebot",
	"mediapartners",
	"Google Favicon",
	"FeedFetcher",
	"Google-Read-Aloud",
	"DuplexWeb-Google",
	"googleweblight",
	"bing",
	"yandex",
	"baidu",
	"duckduck",
	"yahoo",
	"ecosia",
	"ia_archiver",
	"facebook",
	"instagram",
	"pinterest",
	"reddit",
	"slack",
	"twitter",
	"whatsapp",
	"youtube",
	"semrush"
].join("|"), "i");
//#endregion
//#region node_modules/@clerk/shared/dist/runtime/deriveState-CQUgOdaO.mjs
/**
* Derives authentication state based on the current rendering context (SSR or client-side).
*/
var deriveState = (clerkOperational, state, initialState) => {
	if (!clerkOperational && initialState) return deriveFromSsrInitialState(initialState);
	return deriveFromClientSideState(state);
};
var deriveFromSsrInitialState = (initialState) => {
	const userId = initialState.userId;
	const user = initialState.user;
	const sessionId = initialState.sessionId;
	const sessionStatus = initialState.sessionStatus;
	const sessionClaims = initialState.sessionClaims;
	return {
		userId,
		user,
		sessionId,
		session: initialState.session,
		sessionStatus,
		sessionClaims,
		organization: initialState.organization,
		orgId: initialState.orgId,
		orgRole: initialState.orgRole,
		orgPermissions: initialState.orgPermissions,
		orgSlug: initialState.orgSlug,
		actor: initialState.actor,
		factorVerificationAge: initialState.factorVerificationAge
	};
};
var deriveFromClientSideState = (state) => {
	const userId = state.user ? state.user.id : state.user;
	const user = state.user;
	const sessionId = state.session ? state.session.id : state.session;
	const session = state.session;
	const sessionStatus = state.session?.status;
	const sessionClaims = state.session ? state.session.lastActiveToken?.jwt?.claims : null;
	const factorVerificationAge = state.session ? state.session.factorVerificationAge : null;
	const actor = session?.actor;
	const organization = state.organization;
	const orgId = state.organization ? state.organization.id : state.organization;
	const orgSlug = organization?.slug;
	const membership = organization ? user?.organizationMemberships?.find((om) => om.organization.id === orgId) : organization;
	const orgPermissions = membership ? membership.permissions : membership;
	return {
		userId,
		user,
		sessionId,
		session,
		sessionStatus,
		sessionClaims,
		organization,
		orgId,
		orgRole: membership ? membership.role : membership,
		orgSlug,
		orgPermissions,
		actor,
		factorVerificationAge
	};
};
//#endregion
//#region node_modules/@clerk/vue/dist/index.js
var usePortalRoot = () => {
	const context = inject(PortalInjectionKey, null);
	if (context && context.getContainer) return context.getContainer;
	return () => null;
};
var useUser = () => {
	const { userCtx } = useClerkContext("useUser");
	return toComputedRefs(computed(() => {
		if (userCtx.value === void 0) return {
			isLoaded: false,
			isSignedIn: void 0,
			user: void 0
		};
		if (userCtx.value === null) return {
			isLoaded: true,
			isSignedIn: false,
			user: null
		};
		return {
			isLoaded: true,
			isSignedIn: true,
			user: userCtx.value
		};
	}));
};
var useClerkLoaded = (callback) => {
	const clerk = useClerk();
	let unwatch;
	unwatch = watch(clerk, (unwrappedClerk) => {
		if (!unwrappedClerk?.loaded) return;
		callback(unwrappedClerk);
		unwatch?.();
	}, { immediate: true });
};
var ClerkLoaded = /* @__PURE__ */ defineComponent((_, { slots }) => {
	const clerk = useClerk();
	return () => clerk.value?.loaded ? slots.default?.() : null;
});
Object.defineProperty(/* @__PURE__ */ defineComponent((props) => {
	const { sessionCtx, clientCtx } = useClerkContext("RedirectToSignIn");
	useClerkLoaded((clerk) => {
		const hasSignedInSessions = clientCtx.value?.signedInSessions && clientCtx.value.signedInSessions.length > 0;
		if (sessionCtx.value === null && hasSignedInSessions) clerk.redirectToAfterSignOut();
		else clerk.redirectToSignIn(props);
	});
	return () => null;
}), "props", { value: [
	"signInForceRedirectUrl",
	"signInFallbackRedirectUrl",
	"signUpForceRedirectUrl",
	"signUpFallbackRedirectUrl",
	"redirectUrl"
] });
Object.defineProperty(/* @__PURE__ */ defineComponent((props) => {
	useClerkLoaded((clerk) => {
		clerk.redirectToSignUp(props);
	});
	return () => null;
}), "props", { value: [
	"signInForceRedirectUrl",
	"signInFallbackRedirectUrl",
	"signUpForceRedirectUrl",
	"signUpFallbackRedirectUrl",
	"redirectUrl"
] });
Object.defineProperty(/* @__PURE__ */ defineComponent((props) => {
	useClerkLoaded((clerk) => {
		clerk.redirectToTasks(props);
	});
	return () => null;
}), "props", { value: [
	"signInForceRedirectUrl",
	"signInFallbackRedirectUrl",
	"signUpForceRedirectUrl",
	"signUpFallbackRedirectUrl",
	"redirectUrl"
] });
Object.defineProperty(/* @__PURE__ */ defineComponent((props) => {
	useClerkLoaded((clerk) => {
		clerk.handleRedirectCallback(props);
	});
	return () => null;
}), "props", { value: [
	"transferable",
	"signInForceRedirectUrl",
	"signInFallbackRedirectUrl",
	"signUpForceRedirectUrl",
	"signUpFallbackRedirectUrl",
	"signInUrl",
	"signUpUrl",
	"firstFactorUrl",
	"secondFactorUrl",
	"resetPasswordUrl",
	"continueSignUpUrl",
	"verifyEmailAddressUrl",
	"verifyPhoneNumberUrl",
	"reloadResource",
	"unsafeMetadata"
] });
Object.defineProperty(/* @__PURE__ */ defineComponent((props, { slots }) => {
	const { isLoaded, has, userId } = useAuth({ treatPendingAsSignedOut: props.treatPendingAsSignedOut });
	return () => {
		if (!isLoaded.value) return null;
		const authorized = slots.default?.() ?? null;
		const fallbackFromSlot = slots.fallback?.() ?? null;
		const fallbackFromProp = props.fallback ?? null;
		const unauthorized = fallbackFromSlot ?? fallbackFromProp ?? null;
		if (props.when === "signed-out") return userId.value ? unauthorized : authorized;
		if (!userId.value) return unauthorized;
		if (props.when === "signed-in") return authorized;
		const hasValue = has.value;
		if (!hasValue) return unauthorized;
		if (typeof props.when === "function") return props.when(hasValue) ? authorized : unauthorized;
		return hasValue(props.when) ? authorized : unauthorized;
	};
}), "props", { value: [
	"treatPendingAsSignedOut",
	"fallback",
	"when"
] });
var CustomPortalsRenderer = /* @__PURE__ */ defineComponent((props) => {
	return () => [...props?.customPagesPortals ?? [], ...props?.customMenuItemsPortals ?? []];
});
Object.defineProperty(CustomPortalsRenderer, "props", { value: ["customPagesPortals", "customMenuItemsPortals"] });
var ClerkHostRenderer = /* @__PURE__ */ defineComponent({
	props: {
		mount: {
			type: Function,
			required: false
		},
		unmount: {
			type: Function,
			required: false
		},
		open: {
			type: Function,
			required: false
		},
		close: {
			type: Function,
			required: false
		},
		updateProps: {
			type: Function,
			required: false
		},
		props: {
			type: Object,
			required: false,
			default: () => ({})
		}
	},
	setup(props) {
		const portalRef = ref(null);
		const getContainer = usePortalRoot();
		let isPortalMounted = false;
		watchEffect(() => {
			if (!portalRef.value || isPortalMounted) return;
			const propsWithContainer = {
				...props.props,
				getContainer
			};
			if (props.mount) props.mount(portalRef.value, propsWithContainer);
			if (props.open) props.open(propsWithContainer);
			isPortalMounted = true;
		});
		watch(() => props.props, (newProps) => {
			if (isPortalMounted && props.updateProps && portalRef.value) {
				const propsWithContainer = {
					...newProps,
					getContainer
				};
				props.updateProps({
					node: portalRef.value,
					props: propsWithContainer
				});
			}
		}, { deep: true });
		onUnmounted(() => {
			if (isPortalMounted && portalRef.value) {
				if (props.unmount) props.unmount(portalRef.value);
				if (props.close) props.close();
			}
		});
		return () => h(ClerkLoaded, () => h("div", { ref: portalRef }));
	}
});
var _sfc_main9 = /* @__PURE__ */ defineComponent({
	__name: "OrganizationProfile",
	props: {
		path: {
			type: null,
			required: false
		},
		routing: {
			type: String,
			required: false
		},
		afterLeaveOrganizationUrl: {
			type: String,
			required: false
		},
		appearance: {
			type: null,
			required: false
		},
		__experimental_startPath: {
			type: String,
			required: false
		},
		apiKeysProps: {
			type: Object,
			required: false
		}
	},
	setup(__props, { expose: __expose }) {
		__expose();
		const props = __props;
		const clerk = useClerk();
		const { customPages, customPagesPortals, addCustomPage } = useOrganizationProfileCustomPages();
		const finalProps = computed(() => ({
			...props,
			customPages: customPages.value
		}));
		provide(OrganizationProfileInjectionKey, { addCustomPage });
		const __returned__ = {
			props,
			clerk,
			customPages,
			customPagesPortals,
			addCustomPage,
			finalProps,
			get ClerkHostRenderer() {
				return ClerkHostRenderer;
			},
			get CustomPortalsRenderer() {
				return CustomPortalsRenderer;
			}
		};
		Object.defineProperty(__returned__, "__isScriptSetup", {
			enumerable: false,
			value: true
		});
		return __returned__;
	}
});
function _sfc_render9(_ctx, _cache, $props, $setup, $data, $options) {
	return openBlock(), createElementBlock(Fragment, null, [
		createVNode($setup["ClerkHostRenderer"], {
			mount: $setup.clerk?.mountOrganizationProfile,
			unmount: $setup.clerk?.unmountOrganizationProfile,
			props: $setup.finalProps,
			"update-props": $setup.clerk?.__internal_updateProps
		}, null, 8, [
			"mount",
			"unmount",
			"props",
			"update-props"
		]),
		createVNode($setup["CustomPortalsRenderer"], { "custom-pages-portals": $setup.customPagesPortals }, null, 8, ["custom-pages-portals"]),
		renderSlot(_ctx.$slots, "default")
	], 64);
}
var OrganizationProfile_default = /* @__PURE__ */ export_helper_default(_sfc_main9, [["render", _sfc_render9], ["__file", "/home/runner/work/javascript/javascript/packages/vue/src/components/ui-components/OrganizationProfile/OrganizationProfile.vue"]]);
var OrganizationProfilePage = /* @__PURE__ */ defineComponent((props, { slots }) => {
	const ctx = inject(OrganizationProfileInjectionKey);
	if (!ctx) return errorThrower$1.throw(organizationProfilePageRenderedError);
	ctx.addCustomPage({
		props,
		slots,
		component: OrganizationProfilePage
	});
	return () => null;
}, { name: "OrganizationProfilePage" });
Object.defineProperty(OrganizationProfilePage, "props", { value: ["label", "url"] });
var OrganizationProfileLink = /* @__PURE__ */ defineComponent((props, { slots }) => {
	const ctx = inject(OrganizationProfileInjectionKey);
	if (!ctx) return errorThrower$1.throw(organizationProfileLinkRenderedError);
	ctx.addCustomPage({
		props,
		slots,
		component: OrganizationProfileLink
	});
	return () => null;
}, { name: "OrganizationProfileLink" });
Object.defineProperty(OrganizationProfileLink, "props", { value: ["url", "label"] });
Object.assign(OrganizationProfile_default, {
	Page: OrganizationProfilePage,
	Link: OrganizationProfileLink
});
var isThatComponent = (v, component) => {
	return !!v && isRenderFunction(v) && v.name === component.name;
};
var isRenderFunction = (v) => {
	return "name" in v && "setup" in v;
};
function generateElementIdentifier() {
	return Math.random().toString(36).substring(2, 7);
}
var useCustomElementPortal = () => {
	const rawPortals = ref([]);
	const portals = computed(() => {
		return rawPortals.value.map((item) => {
			return h(Teleport, { to: item.el }, item.slot());
		});
	});
	const mount = (el, slot) => {
		const id = generateElementIdentifier();
		el.setAttribute("data-clerk-mount-id", id);
		rawPortals.value.push({
			id,
			el,
			slot
		});
	};
	const unmount = (el) => {
		const id = el?.getAttribute("data-clerk-mount-id");
		if (id) {
			const index = rawPortals.value.findIndex((portal) => portal.id === id);
			if (index !== -1) rawPortals.value.splice(index, 1);
		}
	};
	return {
		portals,
		mount,
		unmount
	};
};
var useUserProfileCustomPages = () => {
	const { customPages, customPagesPortals, addCustomPage } = useCustomPages({
		reorderItemsLabels: [
			"account",
			"security",
			"billing",
			"apiKeys"
		],
		PageComponent: UserProfilePage,
		LinkComponent: UserProfileLink,
		componentName: "UserProfile"
	});
	const addUserProfileCustomPage = (params) => {
		return addCustomPage(params);
	};
	return {
		customPages,
		customPagesPortals,
		addCustomPage: addUserProfileCustomPage
	};
};
var useOrganizationProfileCustomPages = () => {
	const { customPages, customPagesPortals, addCustomPage } = useCustomPages({
		reorderItemsLabels: [
			"general",
			"members",
			"billing",
			"apiKeys"
		],
		PageComponent: OrganizationProfilePage,
		LinkComponent: OrganizationProfileLink,
		componentName: "OrganizationProfile"
	});
	const addOrganizationProfileCustomPage = (params) => {
		return addCustomPage(params);
	};
	return {
		customPages,
		customPagesPortals,
		addCustomPage: addOrganizationProfileCustomPage
	};
};
var useCustomPages = (customPagesParams) => {
	const customPages = ref([]);
	const { portals: customPagesPortals, mount, unmount } = useCustomElementPortal();
	const { PageComponent, LinkComponent, reorderItemsLabels, componentName } = customPagesParams;
	const addCustomPage = (params) => {
		const { props, slots, component } = params;
		const { label, url } = props;
		if (isThatComponent(component, PageComponent)) if (isReorderItem(props, slots, reorderItemsLabels)) customPages.value.push({ label });
		else if (isCustomPage(props, slots)) customPages.value.push({
			label,
			url,
			mountIcon(el) {
				mount(el, slots.labelIcon);
			},
			unmountIcon: unmount,
			mount(el) {
				mount(el, slots.default);
			},
			unmount
		});
		else {
			logErrorInDevMode(customPageWrongProps(componentName));
			return;
		}
		if (isThatComponent(component, LinkComponent)) if (isExternalLink(props, slots)) customPages.value.push({
			label,
			url,
			mountIcon(el) {
				mount(el, slots.labelIcon);
			},
			unmountIcon: unmount
		});
		else {
			logErrorInDevMode(customLinkWrongProps(componentName));
			return;
		}
	};
	return {
		customPages,
		customPagesPortals,
		addCustomPage
	};
};
var isReorderItem = (props, slots, validItems) => {
	const { label, url } = props;
	const { default: defaultSlot, labelIcon } = slots;
	return !defaultSlot && !url && !labelIcon && validItems.some((v) => v === label);
};
var isCustomPage = (props, slots) => {
	const { label, url } = props;
	const { default: defaultSlot, labelIcon } = slots;
	return !!defaultSlot && !!url && !!labelIcon && !!label;
};
var isExternalLink = (props, slots) => {
	const { label, url } = props;
	const { default: defaultSlot, labelIcon } = slots;
	return !defaultSlot && !!url && !!labelIcon && !!label;
};
var _sfc_main10 = /* @__PURE__ */ defineComponent({
	__name: "UserProfile",
	props: {
		path: {
			type: null,
			required: false
		},
		routing: {
			type: String,
			required: false
		},
		appearance: {
			type: null,
			required: false
		},
		additionalOAuthScopes: {
			type: Object,
			required: false
		},
		__experimental_startPath: {
			type: String,
			required: false
		},
		apiKeysProps: {
			type: Object,
			required: false
		}
	},
	setup(__props, { expose: __expose }) {
		__expose();
		const props = __props;
		const clerk = useClerk();
		const { customPages, customPagesPortals, addCustomPage } = useUserProfileCustomPages();
		const finalProps = computed(() => ({
			...props,
			customPages: customPages.value
		}));
		provide(UserProfileInjectionKey, { addCustomPage });
		const __returned__ = {
			props,
			clerk,
			customPages,
			customPagesPortals,
			addCustomPage,
			finalProps,
			get ClerkHostRenderer() {
				return ClerkHostRenderer;
			},
			get CustomPortalsRenderer() {
				return CustomPortalsRenderer;
			}
		};
		Object.defineProperty(__returned__, "__isScriptSetup", {
			enumerable: false,
			value: true
		});
		return __returned__;
	}
});
function _sfc_render10(_ctx, _cache, $props, $setup, $data, $options) {
	return openBlock(), createElementBlock(Fragment, null, [
		createVNode($setup["ClerkHostRenderer"], {
			mount: $setup.clerk?.mountUserProfile,
			unmount: $setup.clerk?.unmountUserProfile,
			props: $setup.finalProps,
			"update-props": $setup.clerk?.__internal_updateProps
		}, null, 8, [
			"mount",
			"unmount",
			"props",
			"update-props"
		]),
		createVNode($setup["CustomPortalsRenderer"], { "custom-pages-portals": $setup.customPagesPortals }, null, 8, ["custom-pages-portals"]),
		renderSlot(_ctx.$slots, "default")
	], 64);
}
var UserProfile_default = /* @__PURE__ */ export_helper_default(_sfc_main10, [["render", _sfc_render10], ["__file", "/home/runner/work/javascript/javascript/packages/vue/src/components/ui-components/UserProfile/UserProfile.vue"]]);
var UserProfilePage = /* @__PURE__ */ defineComponent((props, { slots }) => {
	const ctx = inject(UserProfileInjectionKey);
	if (!ctx) return errorThrower$1.throw(userProfilePageRenderedError);
	ctx.addCustomPage({
		props,
		slots,
		component: UserProfilePage
	});
	return () => null;
}, { name: "UserProfilePage" });
Object.defineProperty(UserProfilePage, "props", { value: ["label", "url"] });
var UserProfileLink = /* @__PURE__ */ defineComponent((props, { slots }) => {
	const ctx = inject(UserProfileInjectionKey);
	if (!ctx) return errorThrower$1.throw(userProfileLinkRenderedError);
	ctx.addCustomPage({
		props,
		slots,
		component: UserProfileLink
	});
	return () => null;
}, { name: "UserProfileLink" });
Object.defineProperty(UserProfileLink, "props", { value: ["url", "label"] });
Object.assign(UserProfile_default, {
	Page: UserProfilePage,
	Link: UserProfileLink
});
var _sfc_main11 = /* @__PURE__ */ defineComponent({
	__name: "OrganizationSwitcher",
	props: {
		createOrganizationUrl: {
			type: null,
			required: false
		},
		createOrganizationMode: {
			type: String,
			required: false
		},
		organizationProfileUrl: {
			type: null,
			required: false
		},
		organizationProfileMode: {
			type: String,
			required: false
		},
		defaultOpen: {
			type: Boolean,
			required: false
		},
		hidePersonal: {
			type: Boolean,
			required: false
		},
		afterCreateOrganizationUrl: {
			type: [Function, Object],
			required: false,
			skipCheck: true
		},
		afterSelectOrganizationUrl: {
			type: [Function, Object],
			required: false,
			skipCheck: true
		},
		afterSelectPersonalUrl: {
			type: [Function, Object],
			required: false,
			skipCheck: true
		},
		afterLeaveOrganizationUrl: {
			type: String,
			required: false
		},
		skipInvitationScreen: {
			type: Boolean,
			required: false
		},
		appearance: {
			type: null,
			required: false
		},
		organizationProfileProps: {
			type: Object,
			required: false
		}
	},
	setup(__props, { expose: __expose }) {
		__expose();
		const clerk = useClerk();
		const props = __props;
		const { customPages, customPagesPortals, addCustomPage } = useOrganizationProfileCustomPages();
		const finalProps = computed(() => ({
			...props,
			organizationProfileProps: {
				...props.organizationProfileProps || {},
				customPages: customPages.value
			}
		}));
		provide(OrganizationProfileInjectionKey, { addCustomPage });
		const __returned__ = {
			clerk,
			props,
			customPages,
			customPagesPortals,
			addCustomPage,
			finalProps,
			get ClerkHostRenderer() {
				return ClerkHostRenderer;
			},
			get CustomPortalsRenderer() {
				return CustomPortalsRenderer;
			}
		};
		Object.defineProperty(__returned__, "__isScriptSetup", {
			enumerable: false,
			value: true
		});
		return __returned__;
	}
});
function _sfc_render11(_ctx, _cache, $props, $setup, $data, $options) {
	return openBlock(), createElementBlock(Fragment, null, [
		createVNode($setup["ClerkHostRenderer"], {
			mount: $setup.clerk?.mountOrganizationSwitcher,
			unmount: $setup.clerk?.unmountOrganizationSwitcher,
			"update-props": $setup.clerk?.__internal_updateProps,
			props: $setup.finalProps
		}, null, 8, [
			"mount",
			"unmount",
			"update-props",
			"props"
		]),
		createVNode($setup["CustomPortalsRenderer"], { "custom-pages-portals": $setup.customPagesPortals }, null, 8, ["custom-pages-portals"]),
		renderSlot(_ctx.$slots, "default")
	], 64);
}
Object.assign(/* @__PURE__ */ export_helper_default(_sfc_main11, [["render", _sfc_render11], ["__file", "/home/runner/work/javascript/javascript/packages/vue/src/components/ui-components/OrganizationSwitcher/OrganizationSwitcher.vue"]]), {
	OrganizationProfilePage,
	OrganizationProfileLink
});
var useUserButtonCustomMenuItems = () => {
	const customMenuItems = ref([]);
	const { portals: customMenuItemsPortals, mount, unmount } = useCustomElementPortal();
	const reorderItemsLabels = ["manageAccount", "signOut"];
	function addCustomMenuItem(params) {
		const { props, component, slots } = params;
		const { label, onClick, open, href } = props;
		if (isThatComponent(component, MenuAction)) if (isReorderItem2(props, slots, reorderItemsLabels)) customMenuItems.value.push({ label });
		else if (isCustomMenuItem(props, slots)) {
			const baseItem = {
				label,
				mountIcon(el) {
					mount(el, slots.labelIcon);
				},
				unmountIcon: unmount
			};
			if (onClick !== void 0) customMenuItems.value.push({
				...baseItem,
				onClick,
				open
			});
			else if (open !== void 0) customMenuItems.value.push({
				...baseItem,
				open: open.startsWith("/") ? open : `/${open}`
			});
			else {
				logErrorInDevMode("Custom menu item must have either onClick or open property");
				return;
			}
		} else {
			logErrorInDevMode(userButtonMenuItemActionWrongProps);
			return;
		}
		if (isThatComponent(component, MenuLink)) if (isExternalLink2(props, slots)) customMenuItems.value.push({
			label,
			href,
			mountIcon(el) {
				mount(el, slots.labelIcon);
			},
			unmountIcon: unmount
		});
		else {
			logErrorInDevMode(userButtonMenuItemLinkWrongProps);
			return;
		}
	}
	return {
		customMenuItems,
		customMenuItemsPortals,
		addCustomMenuItem
	};
};
var isReorderItem2 = (props, slots, validItems) => {
	const { label, onClick } = props;
	const { labelIcon } = slots;
	return !onClick && !labelIcon && validItems.some((v) => v === label);
};
var isCustomMenuItem = (props, slots) => {
	const { label, onClick, open } = props;
	const { labelIcon } = slots;
	return !!labelIcon && !!label && (typeof onClick === "function" || typeof open === "string");
};
var isExternalLink2 = (props, slots) => {
	const { label, href } = props;
	const { labelIcon } = slots;
	return !!href && !!labelIcon && !!label;
};
var _sfc_main13 = /* @__PURE__ */ defineComponent({
	__name: "UserButton",
	props: {
		userProfileUrl: {
			type: null,
			required: false
		},
		userProfileMode: {
			type: String,
			required: false
		},
		showName: {
			type: Boolean,
			required: false
		},
		defaultOpen: {
			type: Boolean,
			required: false
		},
		__experimental_asStandalone: {
			type: [Boolean, Function],
			required: false
		},
		signInUrl: {
			type: String,
			required: false
		},
		afterSwitchSessionUrl: {
			type: String,
			required: false
		},
		appearance: {
			type: null,
			required: false
		},
		userProfileProps: {
			type: Object,
			required: false
		}
	},
	setup(__props, { expose: __expose }) {
		__expose();
		const props = __props;
		const clerk = useClerk();
		const { customMenuItems, customMenuItemsPortals, addCustomMenuItem } = useUserButtonCustomMenuItems();
		const { customPages, customPagesPortals, addCustomPage } = useUserProfileCustomPages();
		const finalProps = computed(() => ({
			...props,
			userProfileProps: {
				...props.userProfileProps || {},
				customPages: customPages.value
			},
			customMenuItems: customMenuItems.value
		}));
		provide(UserButtonInjectionKey, { addCustomMenuItem });
		provide(UserProfileInjectionKey, { addCustomPage });
		const __returned__ = {
			props,
			clerk,
			customMenuItems,
			customMenuItemsPortals,
			addCustomMenuItem,
			customPages,
			customPagesPortals,
			addCustomPage,
			finalProps,
			get ClerkHostRenderer() {
				return ClerkHostRenderer;
			},
			get CustomPortalsRenderer() {
				return CustomPortalsRenderer;
			}
		};
		Object.defineProperty(__returned__, "__isScriptSetup", {
			enumerable: false,
			value: true
		});
		return __returned__;
	}
});
function _sfc_render13(_ctx, _cache, $props, $setup, $data, $options) {
	return openBlock(), createElementBlock(Fragment, null, [
		createVNode($setup["ClerkHostRenderer"], {
			mount: $setup.clerk?.mountUserButton,
			unmount: $setup.clerk?.unmountUserButton,
			props: $setup.finalProps,
			"update-props": $setup.clerk?.__internal_updateProps
		}, null, 8, [
			"mount",
			"unmount",
			"props",
			"update-props"
		]),
		createVNode($setup["CustomPortalsRenderer"], {
			"custom-pages-portals": $setup.customPagesPortals,
			"custom-menu-items-portals": $setup.customMenuItemsPortals
		}, null, 8, ["custom-pages-portals", "custom-menu-items-portals"]),
		renderSlot(_ctx.$slots, "default")
	], 64);
}
var UserButton_default = /* @__PURE__ */ export_helper_default(_sfc_main13, [["render", _sfc_render13], ["__file", "/home/runner/work/javascript/javascript/packages/vue/src/components/ui-components/UserButton/UserButton.vue"]]);
var MenuItems = /* @__PURE__ */ defineComponent((_, { slots }) => {
	const ctx = inject(UserButtonInjectionKey);
	if (!ctx) return errorThrower$1.throw(userButtonMenuItemsRenderedError);
	provide(UserButtonMenuItemsInjectionKey, ctx);
	return () => slots.default?.();
});
var MenuAction = /* @__PURE__ */ defineComponent((props, { slots }) => {
	const ctx = inject(UserButtonMenuItemsInjectionKey);
	if (!ctx) return errorThrower$1.throw(userButtonMenuActionRenderedError);
	ctx.addCustomMenuItem({
		props,
		slots,
		component: MenuAction
	});
	return () => null;
}, { name: "MenuAction" });
Object.defineProperty(MenuAction, "props", { value: [
	"label",
	"onClick",
	"open"
] });
var MenuLink = /* @__PURE__ */ defineComponent((props, { slots }) => {
	const ctx = inject(UserButtonMenuItemsInjectionKey);
	if (!ctx) return errorThrower$1.throw(userButtonMenuLinkRenderedError);
	ctx.addCustomMenuItem({
		props,
		slots,
		component: MenuLink
	});
	return () => null;
}, { name: "MenuLink" });
Object.defineProperty(MenuLink, "props", { value: ["href", "label"] });
var UserButton = Object.assign(UserButton_default, {
	MenuItems,
	Action: MenuAction,
	Link: MenuLink,
	UserProfilePage,
	UserProfileLink
});
var _sfc_main14 = /* @__PURE__ */ defineComponent({
	__name: "SignInButton",
	props: {
		mode: {
			type: String,
			required: false
		},
		appearance: {
			type: null,
			required: false
		},
		fallbackRedirectUrl: {
			type: [String, null],
			required: false
		},
		forceRedirectUrl: {
			type: [String, null],
			required: false
		},
		signUpForceRedirectUrl: {
			type: [String, null],
			required: false
		},
		signUpFallbackRedirectUrl: {
			type: [String, null],
			required: false
		},
		initialValues: {
			type: Object,
			required: false
		},
		withSignUp: {
			type: Boolean,
			required: false
		},
		oauthFlow: {
			type: String,
			required: false
		}
	},
	setup(__props, { expose: __expose }) {
		__expose();
		const props = __props;
		const clerk = useClerk();
		const slots = useSlots();
		const attrs = useAttrs();
		function getChildComponent() {
			return assertSingleChild(normalizeWithDefaultValue(slots.default?.({}), "Sign in"), "SignInButton");
		}
		function clickHandler() {
			const { mode, ...opts } = props;
			if (mode === "modal") return clerk.value?.openSignIn({
				...opts,
				appearance: props.appearance
			});
			const { withSignUp, ...redirectOpts } = opts;
			clerk.value?.redirectToSignIn({
				...redirectOpts,
				signInFallbackRedirectUrl: props.fallbackRedirectUrl,
				signInForceRedirectUrl: props.forceRedirectUrl
			});
		}
		const __returned__ = {
			props,
			clerk,
			slots,
			attrs,
			getChildComponent,
			clickHandler
		};
		Object.defineProperty(__returned__, "__isScriptSetup", {
			enumerable: false,
			value: true
		});
		return __returned__;
	}
});
function _sfc_render14(_ctx, _cache, $props, $setup, $data, $options) {
	return openBlock(), createBlock(resolveDynamicComponent($setup.getChildComponent), mergeProps($setup.attrs, { onClick: $setup.clickHandler }), {
		default: withCtx(() => [renderSlot(_ctx.$slots, "default")]),
		_: 3
	}, 16);
}
var SignInButton_default = /* @__PURE__ */ export_helper_default(_sfc_main14, [["render", _sfc_render14], ["__file", "/home/runner/work/javascript/javascript/packages/vue/src/components/SignInButton.vue"]]);
var SDK_METADATA = {
	name: "@clerk/vue",
	version: "2.0.7",
	environment: "production"
};
var clerkPlugin = { install(app, pluginOptions) {
	const { initialState } = pluginOptions || {};
	const loaded = shallowRef(false);
	const clerk = shallowRef(null);
	const resources = ref({
		client: void 0,
		session: void 0,
		user: void 0,
		organization: void 0
	});
	const options = {
		...pluginOptions,
		sdkMetadata: pluginOptions.sdkMetadata || SDK_METADATA
	};
	if (inBrowser()) (async () => {
		try {
			const clerkPromise = loadClerkJSScript(options);
			const uiProp = pluginOptions.ui;
			const clerkUICtorPromise = uiProp?.ClerkUI ? Promise.resolve(uiProp.ClerkUI) : uiProp || pluginOptions.prefetchUI === false ? Promise.resolve(void 0) : (async () => {
				await loadClerkUIScript(options);
				if (!window.__internal_ClerkUICtor) throw new Error("Failed to download latest Clerk UI. Contact support@clerk.com.");
				return window.__internal_ClerkUICtor;
			})();
			await clerkPromise;
			if (!window.Clerk) throw new Error("Failed to download latest ClerkJS. Contact support@clerk.com.");
			clerk.value = window.Clerk;
			const loadOptions = {
				...options,
				ui: {
					...pluginOptions.ui,
					ClerkUI: clerkUICtorPromise
				}
			};
			await window.Clerk.load(loadOptions);
			loaded.value = true;
			if (clerk.value) {
				clerk.value.addListener((payload) => {
					resources.value = payload;
				});
				triggerRef(clerk);
			}
		} catch (err) {
			const error = err;
			console.error(error.stack || error.message || error);
		}
	})();
	const derivedState = computed(() => deriveState(loaded.value, resources.value, initialState));
	const authCtx = computed(() => {
		const { sessionId, userId, orgId, actor, orgRole, orgSlug, orgPermissions, sessionStatus, sessionClaims, factorVerificationAge } = derivedState.value;
		return {
			sessionId,
			userId,
			actor,
			orgId,
			orgRole,
			orgSlug,
			orgPermissions,
			sessionStatus,
			sessionClaims,
			factorVerificationAge
		};
	});
	const clientCtx = computed(() => resources.value.client);
	const userCtx = computed(() => derivedState.value.user);
	const sessionCtx = computed(() => derivedState.value.session);
	const organizationCtx = computed(() => derivedState.value.organization);
	app.provide(ClerkInjectionKey, {
		loaded,
		clerk,
		authCtx,
		clientCtx,
		sessionCtx,
		userCtx,
		organizationCtx
	});
} };
setErrorThrowerOptions({ packageName: "@clerk/vue" });
setClerkJSLoadingErrorPackageName("@clerk/vue");
//#endregion
//#region src/comps/UserAuth.vue?vue&type=script&setup=true&lang.ts
var _hoisted_1$1 = {
	key: 0,
	class: "flex items-center"
};
var _hoisted_2$1 = {
	key: 0,
	class: "p-[15px]"
};
var _hoisted_3$1 = {
	key: 1,
	class: "flex items-center"
};
var _hoisted_4$1 = /* @__PURE__ */ createBaseVNode("button", { class: "px-2 py-1 bg-indigo-600 hover:bg-indigo-700 text-white rounded-sm shadow-md transition-all flex items-center gap-1" }, [/* @__PURE__ */ createBaseVNode("i", { class: "ri-login-box-line" }), /* @__PURE__ */ createBaseVNode("span", null, "Sign In")], -1);
var _hoisted_5$1 = /* @__PURE__ */ createBaseVNode("div", { class: "px-2" }, "with", -1);
var _hoisted_6$1 = /* @__PURE__ */ createBaseVNode("img", { src: "https://img.clerk.com/static/google.svg?width=160" }, null, -1);
//#endregion
//#region src/comps/UserAuth.vue
var UserAuth_default = /* @__PURE__ */ defineComponent({
	__name: "UserAuth",
	emits: ["changed"],
	setup(__props, { emit: __emit }) {
		const { isSignedIn, user } = useUser();
		const s = glib.vue.reactive({ rt: runtime });
		glib.vue.onMounted(async () => {});
		watch(isSignedIn, async (newVal) => {
			if (newVal === true) {
				console.log("🚀 登录成功，准备联调后端...");
				try {
					const { Er, session, eux } = await post("/api/public/auth", {
						clerkId: user?.value?.id,
						email: user?.value?.primaryEmailAddress?.emailAddress,
						caption: user?.value?.fullName || user?.value?.username,
						avatar: user?.value?.imageUrl
					});
					if (Er === "OK") {
						s.rt.user = eux;
						s.rt.session = session;
					}
				} catch (err) {
					console.error("❌ 请求后端失败，请检查终端日志或 C# 断面:", err);
				}
			}
		});
		return (_ctx, _cache) => {
			const _component_router_link = resolveComponent("router-link");
			return unref(s).rt.user && unref(s).rt.user.eu.id > 0 ? (openBlock(), createElementBlock("div", _hoisted_1$1, [
				createVNode(unref(UserButton)),
				createBaseVNode("div", null, toDisplayString(unref(s).rt.user.eu.p.Email), 1),
				unref(s).rt.user.eu.p.AuthType == 2 ? (openBlock(), createElementBlock("div", _hoisted_2$1, [createVNode(_component_router_link, { to: "/Admin" }, {
					default: withCtx(() => [createTextVNode("Admin")]),
					_: 1
				})])) : createCommentVNode("", true)
			])) : (openBlock(), createElementBlock("div", _hoisted_3$1, [
				createVNode(unref(SignInButton_default), { asChild: "" }, {
					default: withCtx(() => [_hoisted_4$1]),
					_: 1
				}),
				_hoisted_5$1,
				_hoisted_6$1
			]));
		};
	}
});
//#endregion
//#region src/App.vue
var _hoisted_1 = { class: "flex" };
var _hoisted_2 = { class: "lg:w-[1200px] m-[10px]" };
var _hoisted_3 = { class: "main-color w-screen" };
var _hoisted_4 = { class: "w-full flex bg-[#9999ff] px-3 py-1 gap-5" };
var _hoisted_5 = /* @__PURE__ */ createBaseVNode("div", { class: "hor" }, null, -1);
var _hoisted_6 = /* @__PURE__ */ createBaseVNode("div", { class: "flex justify-center" }, [/* @__PURE__ */ createBaseVNode("div", { class: "hor-range" }, [/* @__PURE__ */ createBaseVNode("div", { class: "pt-2 pb-5" }, [/* @__PURE__ */ createBaseVNode("br"), /* @__PURE__ */ createTextVNode("© 2026 WYI ")])])], -1);
var _sfc_main = {
	__name: "App",
	setup(__props) {
		glib.vue.reactive({ rt: runtime });
		return (_ctx, _cache) => {
			const _component_router_link = resolveComponent("router-link");
			const _component_router_view = resolveComponent("router-view");
			return openBlock(), createElementBlock(Fragment, null, [createBaseVNode("div", _hoisted_1, [createVNode(UserAuth_default, { onChanged: _ctx.onAuthChanged }, null, 8, ["onChanged"])]), createBaseVNode("div", _hoisted_2, [createBaseVNode("div", _hoisted_3, [
				createBaseVNode("div", _hoisted_4, [createVNode(_component_router_link, {
					to: "/",
					class: "text-white hover:text-gray-400"
				}, {
					default: withCtx(() => [createTextVNode("Home")]),
					_: 1
				}), createVNode(_component_router_link, {
					to: "/UploadBills",
					class: "text-white hover:text-gray-400"
				}, {
					default: withCtx(() => [createTextVNode("Upload Bills")]),
					_: 1
				})]),
				createVNode(_component_router_view, { class: "min-h-[600px]" }),
				_hoisted_5,
				_hoisted_6
			])])], 64);
		};
	}
};
//#endregion
//#region src/main.ts
var PUBLISHABLE_KEY = "pk_test_ZGVzaXJlZC1ib2FyLTI3LmNsZXJrLmFjY291bnRzLmRldiQ";
globalThis.host = glib.vue.reactive(glib.host.initHost());
globalThis.clientRuntime = glib.vue.reactive(ClientRuntime_empty());
globalThis.runtime = glib.vue.reactive(glib.runtime.prepRuntime());
runtime.host = host;
var lang = localStorage.getItem("runtime.lang");
if (lang) runtime.lang = lang;
else runtime.lang = "";
runtime.session = "" + localStorage.getItem("runtime.session");
var localUser = localStorage.getItem("runtime.user");
if (localUser) runtime.user = JSON.parse(localUser);
else runtime.user = glib.Mor.studio.EuComplex_empty();
glib.runtime.createGlobalWatcher();
glib.notify.init();
var app = glib.vue.createApp(_sfc_main);
app.use(clerkPlugin, { publishableKey: PUBLISHABLE_KEY });
app.use(runtime.router).mount("#app");
if (!runtime.domainname) runtime.domainname = window.location.host;
incomingRoute();
//#endregion
