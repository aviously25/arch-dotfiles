(("undefined"!=typeof self?self:global).webpackChunkopen=("undefined"!=typeof self?self:global).webpackChunkopen||[]).push([[25],{18704:(e,t,r)=>{"use strict";r.r(t),r.d(t,{LyricsContainer:()=>J,default:()=>R});var c=r(27378),s=r.n(c),n=r(79308),a=r(86068),l=r(34514),i=r(94834);const o="lyrics-lyricsContainer-LyricsContainer",u="lyrics-lyricsContainer-Loading",d="lyrics-lyricsContainer-LyricsUnavailablePage",f="lyrics-lyricsContainer-UnsyncedLyricsPage",m="lyrics-lyricsContainer-LyricsUnsyncedMessage",b="lyrics-lyricsContainer-SyncedLyricsPage",v="lyrics-lyricsContainer-LyricsBackground",y="lyrics-lyricsContainer-Provider",p="lyrics-lyricsContainer-SyncedLyrics",g="lyrics-lyricsContainer-LyricsLine",E="lyrics-lyricsContainer-LyricsUnavailableMessage";var O=r(65526),h=r.n(O),N=r(61043),k=r(5640);var D=r(56380),j=r(25033);function w(e,t){const[r,s]=(0,c.useState)(!1),[n,a]=(0,c.useState)(0),l=(0,c.useMemo)((()=>(0,D.J)({lyrics_format:t,track_uri:e})),[t,e]);return(0,c.useEffect)((()=>{s(!1),a(0)}),[l]),(0,c.useEffect)((()=>{if(!r&&n>=150){(0,j.M)().send(l),s(!0)}}),[n,r,l]),a}var x=r(53177);function L(e,t){var r=Object.keys(e);if(Object.getOwnPropertySymbols){var c=Object.getOwnPropertySymbols(e);t&&(c=c.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),r.push.apply(r,c)}return r}function P(e){for(var t=1;t<arguments.length;t++){var r=null!=arguments[t]?arguments[t]:{};t%2?L(Object(r),!0).forEach((function(t){h()(e,t,r[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(r)):L(Object(r)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(r,t))}))}return e}const _={start:0,end:1,text:""},M={"--line-count":3},S=s().memo((({lyrics:e=[],provider:t,trackUri:r})=>{const[n,a]=(0,c.useState)(0),l=w(r,"card");(e=>{const t=(0,c.useRef)();t.current=e,(0,c.useEffect)((()=>{const e=k.O.subscribe("position",(e=>{var r;null===(r=t.current)||void 0===r||r.call(t,e)}));return()=>{k.O.unsubscribe(e)}}),[t])})((e=>a(e)));const i=(0,c.useMemo)((()=>[_,_,...e].map(((e,t)=>P(P({},e),{},{lineNumber:t})))),[e]),o=i.findIndex((({start:e,end:t})=>n>=e&&n<t)),u=(0,c.useMemo)((()=>{const e=Math.max(o-1,0);return i.slice(e,e+3+2)}),[o,i]);return(0,c.useEffect)((()=>{l((e=>i.reduce(((e,{text:t,lineNumber:r})=>{const c=t.length>1?t.length:0;return e+=o===r?c:0}),e)))}),[i,o,l]),s().createElement("div",{className:b,style:M},s().createElement("div",{className:p},u.map((({text:e,lineNumber:t},r)=>{const c={"--animation-index":r};return s().createElement("p",{className:g,style:c,key:t,dir:"auto"},e)}))),t&&s().createElement(x.Dy,{as:"p",variant:x.Dy.mesto,className:y,dir:"auto"},N.ag.get("lyrics.providedBy",t)))}));var C=r(9957);const U=s().memo((({onObserve:e,text:t})=>{const{ref:r,inView:n}=(0,C.YD)({threshold:0});return(0,c.useEffect)((()=>{n&&e(t)}),[n,e,t]),s().createElement("p",{className:g,ref:r,dir:"auto","data-testid":"unsynced-lyric"},t)})),A=s().memo((({lyrics:e=[],provider:t,trackUri:r})=>{const n=w(r,"fullscreen"),a=(0,c.useCallback)((e=>{e.length>1&&n((t=>t+e.length))}),[n]);return s().createElement("div",{className:f},s().createElement(x.Dy.p,{variant:x.$e.ballad,className:m},N.ag.get("lyrics.unsynced")),s().createElement("div",null,e.map((({text:e},t)=>s().createElement(U,{key:r+t,onObserve:a,text:e})))),t&&s().createElement(x.Dy,{as:"p",variant:x.Dy.mesto,className:y,dir:"auto"},N.ag.get("lyrics.providedBy",t)))})),B=[N.ag.get("lyrics.noLyrics0"),N.ag.get("lyrics.noLyrics1"),N.ag.get("lyrics.noLyrics2"),N.ag.get("lyrics.noLyrics3")],I=s().memo((()=>{const e=B[Math.floor(Math.random()*B.length)];return s().createElement("div",{className:d},s().createElement("span",{className:E},e))}));var V=r(96415),W=r(62971),Y=r(4467);const H=s().createElement("div",{className:u},s().createElement(i.H,null)),J=()=>{var e,t,r,c,i,u;const d=(0,n.v9)(V.Ci),f=(null==d?void 0:d.uri)||"",m=(null==d||null===(e=d.album)||void 0===e||null===(t=e.images)||void 0===t||null===(r=t[0])||void 0===r?void 0:r.url)||"",{status:b,data:y}=(0,a.W)(f,m),p=(0,Y.Y)((null==y?void 0:y.colors.dark)||null),[g]=(0,n.v9)(V.e5);(0,a.W)((null==g?void 0:g.uri)||"",(null==g||null===(c=g.album)||void 0===c||null===(i=c.images)||void 0===i||null===(u=i[0])||void 0===u?void 0:u.url)||"");let E=H;if(f)if(b===W.c3.UNAVAILABLE)E=s().createElement(I,null);else if(b===W.c3.LOADED&&y){const{lyrics:e,provider:t,isTimeSynced:r}=y;E=r?s().createElement(S,{trackUri:f,lyrics:e,provider:t}):s().createElement(A,{trackUri:f,lyrics:e,provider:t})}const O={"--lyrics-color-active":(null==y?void 0:y.colors.active)||l.white,"--lyrics-color-inactive":(null==y?void 0:y.colors.bright)||l.black,"--lyrics-color-background":p};return s().createElement("div",{className:o,style:O},s().createElement("div",{className:v}),E)},R=J}}]);