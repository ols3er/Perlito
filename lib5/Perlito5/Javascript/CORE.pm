# Do not edit this file - Generated by Perlito5 8.0
use v5;
use Perlito5::Perl5::Runtime;
our $MATCH = Perlito5::Match->new();
package main;
use v5;
package Perlito5::Javascript::CORE;
sub Perlito5::Javascript::CORE::emit_javascript {
    return ('//' . chr(10) . '//' . chr(10) . '// lib/Perlito5/Javascript/CORE.js' . chr(10) . '//' . chr(10) . '// CORE functions for "Perlito" Perl5-in-Javascript' . chr(10) . '//' . chr(10) . '// AUTHORS' . chr(10) . '//' . chr(10) . '// Flavio Soibelmann Glock  fglock@gmail.com' . chr(10) . '//' . chr(10) . '// COPYRIGHT' . chr(10) . '//' . chr(10) . '// Copyright 2009, 2010, 2011, 2012 by Flavio Soibelmann Glock and others.' . chr(10) . '//' . chr(10) . '// This program is free software; you can redistribute it and/or modify it' . chr(10) . '// under the same terms as Perl itself.' . chr(10) . '//' . chr(10) . '// See http://www.perl.com/perl/misc/Artistic.html' . chr(10) . chr(10) . 'var CORE = p5pkg.CORE;' . chr(10) . chr(10) . 'var isNode = typeof require != "undefined";' . chr(10) . 'if (isNode) {' . chr(10) . '    CORE.print = function(List__) {' . chr(10) . '        var i;' . chr(10) . '        for (i = 0; i < List__.length; i++) {' . chr(10) . '            process.stdout.write(p5str(List__[i]));' . chr(10) . '        }' . chr(10) . '        return 1;' . chr(10) . '    }' . chr(10) . '} else {' . chr(10) . '    CORE.print = function(List__) {' . chr(10) . '        var i;' . chr(10) . '        for (i = 0; i < List__.length; i++) {' . chr(10) . '            write(p5str(List__[i]));' . chr(10) . '        }' . chr(10) . '        return 1;' . chr(10) . '    };' . chr(10) . '}' . chr(10) . chr(10) . 'CORE.say = function(List__) {' . chr(10) . '    CORE.print(List__);' . chr(10) . '    return CORE.print(["' . chr(92) . 'n"]);' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.die = function(List__) {' . chr(10) . '    var i;' . chr(10) . '    var s = "";' . chr(10) . '    for (i = 0; i < List__.length; i++) {' . chr(10) . '        s = s + List__[i];' . chr(10) . '        // s = s + p5str(List__[i]);' . chr(10) . '    }' . chr(10) . '    p5pkg["main"]["v_@"] = "Died: " + s;' . chr(10) . '    throw(new p5_error("Died: " + s));' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.warn = function(List__) {' . chr(10) . '    var i;' . chr(10) . '    var s = "";' . chr(10) . '    for (i = 0; i < List__.length; i++) {' . chr(10) . '        s = s + List__[i];' . chr(10) . '        // s = s + p5str(List__[i]);' . chr(10) . '    }' . chr(10) . '    CORE.print(["Warning: " + s + "' . chr(92) . 'n"]);' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.bless = function(List__) {' . chr(10) . '    var o        = List__[0];' . chr(10) . '    var pkg_name = List__[1];' . chr(10) . '    if (typeof pkg_name === "object") {' . chr(10) . '        // bless {}, Class' . chr(10) . '        o._class_ = pkg_name;' . chr(10) . '        return o;' . chr(10) . '    }' . chr(10) . '    if (!p5pkg.hasOwnProperty(pkg_name)) {' . chr(10) . '        p5make_package(pkg_name);' . chr(10) . '    }' . chr(10) . '    o._class_ = p5pkg[pkg_name];' . chr(10) . '    return o;' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.chr = function(List__) {' . chr(10) . '    return String.fromCharCode(p5num(List__[0]));' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.ord = function(List__) {' . chr(10) . '    return p5str(List__[0]).charCodeAt(0);' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.oct = function(List__) {' . chr(10) . '    var v = List__[0];' . chr(10) . '    var b = v.substr(0,2);' . chr(10) . '    if (b == "0b" || b == "0B") { return parseInt(v.substr(2), 2)  }' . chr(10) . '    if (b == "0x" || b == "0X") { return parseInt(v.substr(2), 16) }' . chr(10) . '    return parseInt(v, 8);' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.abs   = function(List__) { return Math.abs(List__[0]) };' . chr(10) . 'CORE.exp   = function(List__) { return Math.exp(List__[0]) };' . chr(10) . 'CORE.log   = function(List__) { return Math.log(List__[0]) };' . chr(10) . 'CORE.cos   = function(List__) { return Math.cos(List__[0]) };' . chr(10) . 'CORE.sin   = function(List__) { return Math.sin(List__[0]) };' . chr(10) . 'CORE.sqrt  = function(List__) { return Math.sqrt(List__[0]) };' . chr(10) . 'CORE.atan2 = function(List__) { return Math.atan2(List__[0], List__[1]) };' . chr(10) . 'CORE.int   = function(List__) { return List__[0] > 0 ? Math.floor(List__[0]) : Math.ceil(List__[0]) };' . chr(10) . chr(10) . 'CORE.lc      = function(List__) { return List__[0].toLowerCase() };' . chr(10) . 'CORE.uc      = function(List__) { return List__[0].toUpperCase() };' . chr(10) . chr(10) . 'CORE.lcfirst = function(List__) {' . chr(10) . '    var s = List__[0];' . chr(10) . '    var c = s.length > 0 ? s.slice(0,1).toLowerCase() : "";' . chr(10) . '    s = s.length > 1 ? substr(s, 1) : "";' . chr(10) . '    return c + s' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.ucfirst = function(List__) {' . chr(10) . '    var s = List__[0];' . chr(10) . '    var c = s.length > 0 ? s.slice(0,1).toUpperCase() : "";' . chr(10) . '    s = s.length > 1 ? substr(s, 1) : "";' . chr(10) . '    return c + s' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.substr = function(List__) {' . chr(10) . '    var expr        = List__[0];' . chr(10) . '    var offset      = List__[1];' . chr(10) . '    var length      = List__[2];' . chr(10) . '    var replacement = List__[3];' . chr(10) . '    if (length < 0) {' . chr(10) . '        var s = p5str(expr);' . chr(10) . '        length = s.length - offset + length;' . chr(10) . '    } ' . chr(10) . '    return p5str(expr).substr(offset, length);' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.scalar = function(List__) {' . chr(10) . '    var o = List__[0];' . chr(10) . '    if (o == null) {' . chr(10) . '        return o;' . chr(10) . '    };' . chr(10) . '    if (typeof o.scalar === "function") {' . chr(10) . '        return o.scalar();' . chr(10) . '    }' . chr(10) . '    if (typeof o === "object" && (o instanceof Array)) {' . chr(10) . '        return o.length;' . chr(10) . '    }' . chr(10) . '    switch (typeof o) {' . chr(10) . '        case "string":   return o;' . chr(10) . '        case "function": return o;' . chr(10) . '        case "number":   return o;' . chr(10) . '        case "boolean":  return o;' . chr(10) . '    }' . chr(10) . '    var l = 0;' . chr(10) . '    for (var i in o) {' . chr(10) . '        l++;' . chr(10) . '    }' . chr(10) . '    return l;' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.values = function(List__, p5want) {' . chr(10) . '    var o = List__[0];' . chr(10) . '    delete o["_each_"];' . chr(10) . '    if (p5want) {' . chr(10) . '        if (o == null) {' . chr(10) . '            return [];' . chr(10) . '        };' . chr(10) . '        if (typeof o.values === "function") {' . chr(10) . '            return o.values();' . chr(10) . '        }' . chr(10) . '        var out = [];' . chr(10) . '        for (var i in o) {' . chr(10) . '            out.push(o[i]);' . chr(10) . '        }' . chr(10) . '        return out;' . chr(10) . '    }' . chr(10) . '    return CORE.keys(List__, p5want);' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.keys = function(List__, p5want) {' . chr(10) . '    var o = List__[0];' . chr(10) . '    delete o["_each_"];' . chr(10) . '    if (p5want) {' . chr(10) . '        if (o == null) {' . chr(10) . '            return [];' . chr(10) . '        }' . chr(10) . '        if (typeof o.keys === "function") {' . chr(10) . '            return o.keys();' . chr(10) . '        }' . chr(10) . '        var out = [];' . chr(10) . '        for (var i in o) {' . chr(10) . '            out.push(i);' . chr(10) . '        }' . chr(10) . '        return out;' . chr(10) . '    }' . chr(10) . '    else {' . chr(10) . '        if (o == null) {' . chr(10) . '            return 0;' . chr(10) . '        }' . chr(10) . '        if (typeof o.keys === "function") {' . chr(10) . '            return CORE.scalar([o.keys()]);' . chr(10) . '        }' . chr(10) . '        var out = 0;' . chr(10) . '        for (var i in o) {' . chr(10) . '            out++;' . chr(10) . '        }' . chr(10) . '        return out;' . chr(10) . '    }' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.each = function(List__, p5want) {' . chr(10) . '    var o = List__[0];' . chr(10) . '    if (o.hasOwnProperty("_each_")) {' . chr(10) . '        return o._each_(p5want)' . chr(10) . '    }' . chr(10) . '    var keys = CORE.keys([o], 1);' . chr(10) . '    var i = 0;' . chr(10) . '    o._each_ = function () {' . chr(10) . '        if (i < keys.length) {' . chr(10) . '            i++;' . chr(10) . '            return p5want ? [keys[i-1], o[keys[i-1]]] : keys[i-1];' . chr(10) . '        }' . chr(10) . '        i = 0;' . chr(10) . '        return p5want ? [] : null;' . chr(10) . '    };' . chr(10) . '    return o._each_(p5want);' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.reverse = function(List__) {' . chr(10) . '    var o = List__[0];' . chr(10) . '    if (o == null) {' . chr(10) . '        return "";' . chr(10) . '    }' . chr(10) . '    if (typeof o === "string") {' . chr(10) . '        return o.split("").reverse().join("")' . chr(10) . '    }' . chr(10) . '    var out = [];' . chr(10) . '    for(var i = 0; i < o.length; i++) {' . chr(10) . '        out.unshift(o[i]);' . chr(10) . '    }' . chr(10) . '    return out;' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.splice = function(List__, p5want) {' . chr(10) . '    var array  = List__.shift();' . chr(10) . '    // CORE.say([ array ]);' . chr(10) . '    var offset = p5num(List__.shift());' . chr(10) . '    var limit  = List__.length ? p5num(List__.shift()) : (array.length + 1);' . chr(10) . chr(10) . '    if (limit < 0) {' . chr(10) . '        limit = array.length + limit - 1;' . chr(10) . '    }' . chr(10) . chr(10) . '    var list = [offset, limit];' . chr(10) . '    for(var i = 0; i < List__.length; i++) {' . chr(10) . '        list = interpolate_array( list, List__[i]);' . chr(10) . '    }' . chr(10) . chr(10) . '    out = array.splice.apply(array, list);' . chr(10) . '    // CORE.say([ CORE.join([":",array]), " ofs=", offset, " lim=", limit, " list=", list, " out=", CORE.join([":",out])  ]);' . chr(10) . '    return p5want ? out : out.pop();' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.pop = function(List__) {' . chr(10) . '    var o = List__[0];' . chr(10) . '    if (o.length == null) {' . chr(10) . '        return null;' . chr(10) . '    }' . chr(10) . '    return o.pop();' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.shift = function(List__) {' . chr(10) . '    var o = List__[0];' . chr(10) . '    if (o.length == null) {' . chr(10) . '        return null;' . chr(10) . '    }' . chr(10) . '    return o.shift();' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.push = function(List__) {' . chr(10) . '    var o = List__[0];' . chr(10) . '    var v = List__[1];' . chr(10) . '    for(var i = 0; i < v.length; i++) {' . chr(10) . '        o.push(v[i]);' . chr(10) . '    }' . chr(10) . '    return o.length;' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.unshift = function(List__) {' . chr(10) . '    var o = List__[0];' . chr(10) . '    var v = List__[1];' . chr(10) . '    for(var i = v.length-1; i >= 0; i--) {' . chr(10) . '        o.unshift(v[i]);' . chr(10) . '    }' . chr(10) . '    return o.length;' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.join = function(List__) {' . chr(10) . '    var s = List__[0];' . chr(10) . '    var o = List__[1];' . chr(10) . '    return o.join(s);' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.index = function(List__) {' . chr(10) . '    var o = List__[0];' . chr(10) . '    var s = List__[1];' . chr(10) . '    try {' . chr(10) . '        return o.indexOf(s);' . chr(10) . '    }' . chr(10) . '    catch(err) {' . chr(10) . '        return -1;' . chr(10) . '    }' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.length = function(List__) {' . chr(10) . '    var o = List__[0];' . chr(10) . '    if (typeof o.string === "function") {' . chr(10) . '        return o.string().length;' . chr(10) . '    }' . chr(10) . '    return o.length;' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.pack    = function(List__) { CORE.warn([ "CORE::pack not implemented" ]) };' . chr(10) . 'CORE.unpack  = function(List__) { CORE.warn([ "CORE::unpack not implemented" ]) };' . chr(10) . 'CORE.sprintf = function(List__) { CORE.warn([ "CORE::sprintf not implemented" ]) };' . chr(10) . chr(10) . 'CORE.ref = function(List__) {' . chr(10) . '    var o = List__[0];' . chr(10) . '    if (o == null) {' . chr(10) . '        return "";' . chr(10) . '    }' . chr(10) . '    if (o._class_ && typeof o._class_._ref_ === "string") {' . chr(10) . '        // blessed reference' . chr(10) . '        return o._class_._ref_;' . chr(10) . '    }' . chr(10) . '    if (typeof o._ref_ === "string") {' . chr(10) . '        // un-blessed reference' . chr(10) . '        return o._ref_;' . chr(10) . '    }' . chr(10) . '    if (typeof o === "function") {' . chr(10) . '        return "CODE";' . chr(10) . '    }' . chr(10) . '    return "";' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.split = function(List__) {' . chr(10) . '    var pattern = List__[0];' . chr(10) . '    var s       = List__[1];' . chr(10) . '    var limit   = List__[2];' . chr(10) . '    if (typeof pattern === "string") {' . chr(10) . '        if (pattern == " ") {' . chr(10) . '            var res = [];' . chr(10) . '            for (var i_ = 0, a_ = s.split(/(?: |' . chr(92) . 'n)+/); i_ < a_.length ; i_++) {' . chr(10) . '                if (a_[i_] != "") {' . chr(10) . '                    res.push(a_[i_])' . chr(10) . '                }' . chr(10) . '            }' . chr(10) . '            return res;' . chr(10) . '        }' . chr(10) . '    }' . chr(10) . '    CORE.die(["not implemented"]);' . chr(10) . '};' . chr(10) . chr(10) . 'CORE.prototype = function(List__, data) {' . chr(10) . '    var name = List__[0];' . chr(10) . '    // TODO - fully qualify "name" using information from "data"' . chr(10) . '    // XXX - lookup in CORE::GLOBAL?' . chr(10) . '    p5pkg["Perlito5"].v_PROTO._hash_[name] || p5pkg["Perlito5"].v_CORE_PROTO._hash_[name]' . chr(10) . '};' . chr(10) . chr(10))
};
1;

1;
