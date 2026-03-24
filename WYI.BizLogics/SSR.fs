module WYI.BizLogics.SSR

open System
open System.Text
open System.Collections.Generic
open System.Threading

open Microsoft.AspNetCore
open Microsoft.AspNetCore.Http

open Util.Cat
open Util.Text
open Util.Bin
open Util.Perf
open Util.Json
open Util.Http
open Util.HttpServer
open Util.Zmq

open WYI.Shared.OrmTypes
open WYI.Shared.Types
open WYI.Shared.OrmMor
open WYI.Shared.CustomMor

open UtilWebServer.Common
open UtilWebServer.Api
open UtilWebServer.Json
open UtilWebServer.SSR
open UtilWebServer.Kestrel

open WYI.BizLogics.Common
open WYI.BizLogics.Branch

let ssrPageHome = {
    title = "SDCHEN FINE ART STUDIO"
    desc = "Portrait painting"
    image = "https://i.imgur.com/JvdrjQP.png"
    url = runtime.host.url
    noscript = "" }

let renderGoogleAds = 
    """
    <!-- Google tag (gtag.js) -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=AW-11507607517">
    </script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());

      gtag('config', 'AW-11507607517');
    </script>

    <!-- Event snippet for Page view conversion page
    In your html page, add the snippet and call gtag_report_conversion when someone clicks on the chosen link or button. -->
    <script>
    function gtag_report_conversion(url) {
      var callback = function () {
        if (typeof(url) != 'undefined') {
          window.location = url;
        }
      };
      gtag('event', 'conversion', {
          'send_to': 'AW-11507607517/O1yWCP6F2vkZEN3PoO8q',
          'value': 1.0,
          'currency': 'USD',
          'event_callback': callback
      });
      return false;
    }
    </script>


    """

let r1 = str__regex @"\w+"

let pages = [|
    "/admin" |]

let echo (kestrelx:KestrelCtx) = 
    let vueDeployDir = runtime.host.req__vueDeployDir

    kestrelx
    |> Suc
    |> bind (homepage runtime.langs pages ssrPageHome vueDeployDir renderGoogleAds)
    //|> bindFail (hSEO (fun x -> [||]) "")
    //|> bindFail (hapi echoApiHandler (branch (scheme,api) hx)) 
    |> ignore


