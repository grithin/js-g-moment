(function(){global="undefined"!=typeof global&&global||"undefined"!=typeof window&&window||this;var t,e,n,i;t=global.lodash||global._||require("lodash"),i=global.moment||require("moment"),i.DATE="YYYY-MM-DD",i.DATETIME="YYYY-MM-DD HH:mm:ss",i.prototype.to_date=function(){return this.format(i.DATE)},i.prototype.to_datetime=function(){return this.format(i.DATETIME)},n=new function(){var e,n,r;this.date=function(){return i.utc().to_date()},this.datetime=function(){return i.utc().to_datetime()},this.numbers={zero:0,one:1,two:2,three:3,four:4,five:5,six:6,seven:7,eight:8,nine:9,ten:10,eleven:11,twelve:12,thirteen:13,fourteen:14,fifteen:15,sixteen:16,seventeen:17,eighteen:18,nineteen:19,twenty:20,thirty:30,forty:40,fifty:50,sixty:60,seventy:70,eighty:80,ninety:90,hundred:100,thousend:1e3,million:1e6},this.units={millisecond:1,ms:1,second:1e3,sec:1e3,s:1e3,minute:6e4,min:6e4,m:6e4,hour:36e5,hr:36e5,h:36e5,day:864e5,d:864e5,week:6048e5,w:6048e5,month:2592e6,quarter:7776e6,year:31536e6,y:31536e6,decade:31536e7},n=this.units;for(e in n)r=n[e],e.length>1&&(this.units[e+"s"]=r);return this.relative=function(e,n){var s,o,a,u,f,h,m,c;if(n=n?this.guess(n).time:i(),"string"!=typeof e)return i(e);if(e=t.trim(e).toLowerCase(),u=1,["-","+"].indexOf(e[0])!==-1)"-"===e[0]&&(u=-1),e=t.trim(e.substr(1));else{if("ago"!==e.slice(-3))return i(e);u=-1,e=t.trim(e.slice(0,-3))}for(e=this.replace_text_number(e),e=e.replace(/(\s+and\s+)|(\s+&\s+)|\s+,\s+/,","),m=e.split(","),f=0,o=0,a=m.length;o<a;o++){if(h=m[o],c=h.split(/\s+/),r=c.pop(),s=parseFloat(c.join("")),!this.units[r])throw new Error("Unit not found in "+e);f+=u*this.units[r]*s}return i(parseInt(n.format("x"))+f)},this.unix=function(t){return t?parseInt(i.utc(t).local().format("X")):parseInt(i().format("X"))},this.isDst=function(t){return t=t||new Date,t.getTimezoneOffset()<this.stdTimezoneOffset(t)},this.stdTimezoneOffset=function(t){var e,n;return t=t||new Date,e=new Date(t.getFullYear(),0,1),n=new Date(t.getFullYear(),6,1),Math.max(e.getTimezoneOffset(),n.getTimezoneOffset())},this.start_of_day=function(t){return i(i(t).format("YYYY-MM-DD")+" 00:00:00")},this.date_by_clock=function(t,e){return i.unix(parseInt(this.start_of_day(e).format("X"))+parseInt(t)).format("YYYY-MM-DD HH:mm:ss")},this.seconds_of_today=function(t){var e,n,i;return n=t.match(/^\s*([0-9]{1,2})(:([0-9]{1,2}))\s*(am|pm)\s*$/i),!!n&&(e=parseInt(n[1]),i=parseInt(n[3]),"pm"===n[4].toLowerCase()?12!==e&&(e+=12):12===e&&(e=0),3600*e+60*i)},this.unix=function(){return parseInt(i().format("X"))},this.replace_text_number=function(t){var e,n,i;n=this.numbers;for(i in n)e=n[i],t=t.replace(i,e);return t},this.from_guess=function(t){var e,n;try{if(n=this.guess(t))return n.time}catch(t){e=t}return!1},this.guess=function(t){var e;return"now"!==t&&t&&""!==t?parseInt(t)+""===t?{time:i.unix(parseInt(t)),type:"unix"}:t instanceof Date||t instanceof i?{time:i(t),type:"Date"}:t.match(/^[0-9]{4}\-[0-9]{2}\-[0-9]{2}( [0-9]{2}:[0-9]{2}:[0-9]{2})?$/)?{time:i(t),type:"date"}:(e=this.seconds_of_today(t),e!==!1?{time:this.date_by_clock(e),type:"clock"}:(t=this.replace_text_number(t),t.match(/^\s*([-+])\s*[\-0-9]/)||t.match(/ago\s*$/i)?{time:this.relative(t),type:"relative"}:void 0)):{time:i(),type:"now"}},this},t.bindSelf(n),e=function(){return n},"function"==typeof define&&define.amd?define([],e):"object"==typeof exports?module.exports=e():(this.returnExports=e(),this.Time||(this.Time=this.returnExports))}).call(this);
//# sourceMappingURL=main.js.map
