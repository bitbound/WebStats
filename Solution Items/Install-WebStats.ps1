<#
.Synopsis
   Installs the WebStats HTTP module on all local IIS sites.
.DESCRIPTION
   Installs the WebStats HTTP module on all local IIS sites.
.AUTHOR
   Jared
.UPDATED
   February 4, 2019
#>

$ErrorActionPreference = "Stop"

$HttpModuleBase64 = "TVqQAAMAAAAEAAAA//8AALgAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAA4fug4AtAnNIbgBTM0hVGhpcyBwcm9ncmFtIGNhbm5vdCBiZSBydW4gaW4gRE9TIG1vZGUuDQ0KJAAAAAAAAABQRQAATAEDALTRF+gAAAAAAAAAAOAAIiALATAAAC4AAAAIAAAAAAAA8k0AAAAgAAAAYAAAAAAAEAAgAAAAAgAABAAAAAAAAAAGAAAAAAAAAACgAAAAAgAAAAAAAAMAYIUAABAAABAAAAAAEAAAEAAAAAAAABAAAAAAAAAAAAAAAJ1NAABPAAAAAGAAABQEAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAwAAAAITQAAOAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAACAAAAAAAAAAAAAAACCAAAEgAAAAAAAAAAAAAAC50ZXh0AAAA+C0AAAAgAAAALgAAAAIAAAAAAAAAAAAAAAAAACAAAGAucnNyYwAAABQEAAAAYAAAAAYAAAAwAAAAAAAAAAAAAAAAAABAAABALnJlbG9jAAAMAAAAAIAAAAACAAAANgAAAAAAAAAAAAAAAAAAQAAAQgAAAAAAAAAAAAAAAAAAAADRTQAAAAAAAEgAAAACAAUAqCkAABgdAAABAAAAAAAAAMBGAABIBgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABp+AQAABCoeAnsCAAAEKiICA30CAAAEKh4CewMAAAQqIgIDfQMAAAQqHgJ7BAAABCoiAgN9BAAABCoAABswAgAuAAAAAQAAEQAoAQAABgoWCwYSASgRAAAKAAACKAQAAAZvEAAABgAA3gsHLAcGKBIAAAoA3CoAAAEQAAACAAkAGSIACwAAAAAbMAIALgAAAAEAABEAKAEAAAYKFgsGEgEoEQAACgAAAigEAAAGbw8AAAYAAN4LBywHBigSAAAKANwqAAABEAAAAgAJABkiAAsAAAAAagACFCgFAAAGAAIUKAMAAAYAAhQoBwAABgAqwgACAygMAAAGAAMC/gYIAAAGcxMAAApvFAAACgADAv4GCQAABnMTAAAKbxUAAAoAKhMwBQBDAAAAAAAAAAACKAEAAAZzMQAABigHAAAGAAICKAYAAAZzHAAABigDAAAGAAIDKAEAAAYCKAYAAAYCKAIAAAZzPgAABigFAAAGACoiAigWAAAKACoucxcAAAqAAQAABCpCAigWAAAKAAACA30FAAAEKh4CewUAAAQqHgJ7BgAABCoiAgN9BgAABCoAABswBAA3AQAAAgAAEQACKB4AAAYoGAAAChMGEQYsTAAoGQAACnIBAABwbxoAAAoTBwARB3MbAAAKEwgAAhEIbxwAAAooHwAABgAA3g0RCCwIEQhvHQAACgDcAN4NEQcsCBEHbx0AAAoA3AACKB0AAAZvEgAABgoCKB0AAAZvFAAABgsCKB0AAAZvEQAABgwCKB0AAAZvEwAABg0CKB0AAAYDbxUAAAYTBAIoHQAABgNvFgAABhMFAigeAAAGckkAAHBydQAAcAaMJwAAASgeAAAKbx8AAApygwAAcHJ1AABwB4woAAABKB4AAApvHwAACnKnAABwctMAAHAIjCcAAAEoHgAACm8fAAAKct8AAHBydQAAcAmMKAAAASgeAAAKbx8AAApyAwEAcBEEbx8AAApyHQEAcBEFbx8AAAoTCSsAEQkqAAEcAAACAC4AEkAADQAAAAACACQALFAADQAAAABGAiggAAAKAAACAygwAAAGACoeAnsHAAAEKiICA30HAAAEKjICKC8AAAZvIQAACioyAigvAAAGbyIAAAoqMgIoLwAABm8jAAAKKjICKC8AAAZvJAAACioAEzABABEAAAADAAARAAIoLwAABm8lAAAKCisABio+AAIoLwAABgNvJgAACgAqOgACKC8AAAZvJwAACgAqEzAEABQAAAAEAAARAAIoLwAABgMEBW8oAAAKCisABioTMAMAEwAAAAMAABEAAigvAAAGAwRvKQAACgorAAYqPgACKC8AAAYDbyoAAAoAKo4AAgIoIgAABgOOaWpYKCMAAAYAAigvAAAGAwQFbysAAAoAKh4CewgAAAQqIgIDfQgAAAQqQgIoFgAACgAAAgN9CQAABCoeAnsJAAAEKgAAABMwAgAtAAAABQAAEQACKD0AAAYKBm8sAAAKFv4BCwcsDQAjAAAAAAAAAAAMKwkGKC0AAAoMKwAIKgAAABMwAgAuAAAABQAAEQACKD0AAAYKBm8sAAAKFv4BCwcsDQAjAAAAAAAAAAAMKwoGKAEAACtsDCsACCoAABMwAgAmAAAABgAAEQACKD0AAAYKBm8sAAAKFv4BCwcsBgAWagwrCQYoLwAACgwrAAgqAAATMAMASgAAAAYAABEAAig9AAAGCgZvLAAAChb+AQsHLAYAFmoMKy0Gfg8AAAQlLRcmfg4AAAT+BkkAAAZzMAAACiWADwAABCgCAAArKDIAAAoMKwAIKgAAEzADAGwAAAAHAAARAAIoMgAABnI5AQBwAygzAAAKbzQAAAoW/gELBywJAHJRAQBwDCtDAigyAAAGcjkBAHADKDMAAApvNQAACnQYAAABCgZvNgAACgByZQEAcAZvNwAACg0SAyg4AAAKjCcAAAEoHgAACgwrAAgqEzADAGwAAAAHAAARAAIoMgAABnJzAQBwAygzAAAKbzQAAAoW/gELBywJAHJRAQBwDCtDAigyAAAGcnMBAHADKDMAAApvNQAACnQYAAABCgZvNgAACgByZQEAcAZvNwAACg0SAyg4AAAKjCcAAAEoHgAACgwrAAgqEzADACUAAAAIAAARACg5AAAKCgIoMgAABnI5AQBwAygzAAAKBm86AAAKAAYLKwAHKgAAABMwAwAlAAAACAAAEQAoOQAACgoCKDIAAAZycwEAcAMoMwAACgZvOgAACgAGCysAByoAAAATMAIAEQAAAAkAABEAAig9AAAGCgYDbzsAAAoAKgAAABMwAwAtAAAACgAAEQACKD0AAAYKKxEABgZvLAAAChdZbzwAAAoAAAZvLAAACiCIEwAA/gILBy3eKgAAABMwAwBnAAAACwAAEQACKDIAAAZyjQEAcG80AAAKLB0CKDIAAAZyjQEAcG81AAAKdQIAABsU/gMW/gErARcKBiwYAAIoMgAABnKNAQBwcz0AAApvOgAACgAAAigyAAAGco0BAHBvNQAACnUCAAAbCysAByqeAigWAAAKAAACA30KAAAEAgV9CwAABAIOBH0MAAAEAgQoQwAABgAqHgJ7CgAABCoeAnsLAAAEKh4CewwAAAQqHgJ7DQAABCoiAgN9DQAABCoTMAMAZQAAAAwAABEAKD4AAAoLEgH+Fh8AAAFvPwAACgoCKD8AAAZvQAAACm9BAAAKcqkBAHAGb0IAAAoAAihAAAAGBm8YAAAGJgIoPwAABm9DAAAKAig/AAAGb0MAAApvRAAACnMhAAAGb0UAAAoAKgAAABMwAgCXAAAADQAAEQACKD8AAAZvQAAACm9BAAAKcqkBAHBvRgAACgoCKEAAAAYGbxcAAAYmAihAAAAGAig/AAAGb0MAAApvRAAACnUHAAACbyIAAAZvGQAABgACKD8AAAZvQwAACm9HAAAKcs0BAHAoSAAACgsHLCEAAihBAAAGBm8bAAAGDAIoPwAABm9DAAAKCG9JAAAKAAACBihGAAAGACoAEzADAFcAAAAAAAAAAAIoPwAABm9AAAAKb0EAAApyqQEAcG9KAAAKAAIoQgAABnI5AQBwAygzAAAKb0sAAAomAihCAAAGcnMBAHADKDMAAApvSwAACiYCKEAAAAZvGgAABgAqLnNIAAAGgA4AAAQqIgIoFgAACgAqGgMWav4CKgBCU0pCAQABAAAAAAAMAAAAdjQuMC4zMDMxOQAAAAAFAGwAAABoDAAAI34AANQMAABsCgAAI1N0cmluZ3MAAAAAQBcAAOQBAAAjVVMAJBkAABAAAAAjR1VJRAAAADQZAADkAwAAI0Jsb2IAAAAAAAAAAgAAAVcXogkJCwAAAPoBMwAWAAABAAAALQAAAAoAAAAPAAAASQAAACwAAAAEAAAASwAAAD0AAAANAAAABQAAABIAAAAaAAAABAAAAAEAAAAEAAAAAQAAAAEAAAACAAAAAACqBQEAAAAAAAYAPAQ0CAYAqQQ0CAYAVQPYBw8AVAgAAAYAmAOUBgYAHwSUBgYAAASUBgYAkASUBgYAXASUBgYAdQSUBgYArwOUBgYAhAMVCAYARwMVCAYA4wOUBgYAygNWBQYAAQk8BgoAOgJ2AAYALAM0CAYA8ALYBwYAaQPYBwYAQQCOAAYAdQg8BgoAhAZ2AA4AeQXYBwYAIwZsAAYA5QZsAAYAcgZsAAYAMwCOAAYAQwY8BgYAOgA8BgYA5wA8BgYA0AdFBQYACwc8BgYAQgCOAAYAcgU8BgYAVwqUBgYA8gZsAAYAJwI8BgYAMwI8BgYATwA8BhIAHALZBgYAJQCOAAoA6Al2AA4ApgbFAAoA2wJ2AAAAAABZAAAAAAABAAEAAQAQAEYCpAhBAAEAAQChAAAARgcBCAAABQAPAKEAAACtCAEIAAAFABEAoQAAAIIHAQgAAAUAGwABABAApwd/CEEABQAcAAEAEAAuB38IZQAHACEAAQAQANAIfwhBAAkAMQABABAAcQd/CEEACgA+AAMhEACKAAAAQQAOAEcAMQDsALsBAQBoAcMBAQBGAccBAQCHAcsBIQCHAcsBAQClAc8BAQAoAdIBAQAIAdUBIQDsALsBIQDEAdkBIQCHAcsBIQBoAcMBAQDsALsBNgBVAN0BFgABAOEBUCAAAAAAkQilAukBAQBXIAAAAACBCJEH8gEBAF8gAAAAAIEIowf3AQEAaCAAAAAAgQhYB/0BAgBwIAAAAACBCG0HAgICAHkgAAAAAIEIuwgIAgMAgSAAAAAAgQjMCA0CAwCMIAAAAACGANMJEwIEANggAAAAAIYArwkTAgYAJCEAAAAA5gHoAgYACAA/IQAAAADmAR4JGgIIAHAhAAAAAIEAYwgaAgkAvyEAAAAAhhjDBwYACgDIIQAAAACRGMkHIAIKAAAAAAAAAMYF5wEGAAoAAAAAAAAAxgV7CQYACgAAAAAAAADGBdQEOAEKAAAAAAAAAMYFDgU4AQoAAAAAAAAAxgUlBYUACgAAAAAAAADGBfsEhQAKAAAAAAAAAMYFUgKeAQoAAAAAAAAAxgVqAp4BCwAAAAAAAADGBVwJJAIMAAAAAAAAAMYFawkkAg0AAAAAAAAAxgXrBI0ADgAAAAAAAADGBfQJBgAPAAAAAAAAAMYFCAmeAQ8A1CEAAAAAhhjDBw0CEADlIQAAAACBCLsICAIRAO0hAAAAAIEIKAlxABEA9SEAAAAAgQg6CRAAEQAAIgAAAADmAQgJngESAGAjAAAAAIYYwwdrABMAciMAAAAAhghMBoUAFAB6IwAAAACGCF0GjQAUAIMjAAAAAMYIqQCBABUAkCMAAAAAxgieBYEAFQCdIwAAAADGCB8DgQAVAKojAAAAAMYIiQWFABUAuCMAAAAAxgi6BoUAFQDVIwAAAADGCMcGjQAVAOUjAAAAAMYAgwUGABYA9CMAAAAAxgCwAJYAFgAUJAAAAADGAKUFngAZADMkAAAAAMYAlAWNABsAQyQAAAAAxgAmA6UAHABnJAAAAACBCPUFkwEfAG8kAAAAAIEICAZrAB8AeCQAAAAAhhjDByoCIACJJAAAAACBCKUCNAIhAJQkAAAAAOYB1AQ4ASEA0CQAAAAA5gEOBTgBIQAMJQAAAADmASUFhQAhAEAlAAAAAOYB+wSFACEAmCUAAAAA5gFSAp4BIQAQJgAAAADmAWoCngEiAIgmAAAAAOYBXAkkAiMAvCYAAAAA5gFrCSQCJADwJgAAAADmAesEjQAlABAnAAAAAOYB9AkGACYATCcAAAAAgQAJCj0CJgC/JwAAAACGGMMHRQImAOcnAAAAAIEIHgpVAioA7ycAAAAAgQi7CAgCKgD3JwAAAACBCJEH8gEqAP8nAAAAAIEIpQI0AioABygAAAAAgQi0AioCKgAQKAAAAADmAXsJBgArAIQoAAAAAOYB5wEGACsAKCkAAAAAgQAHAxAAKwCLKQAAAACRGMkHIAIsAJcpAAAAAIYYwwcGACwAoCkAAAAAgwAKAFoCLAAAAAEAxwQAAAEAxwQAAAEAxwQAAAEA/QYAAAIAQwUAAAEA/QYAAAIAQwUAAAEAKgoAAAEAKgoAAAEAYgAAAAEAYgAAAAEAYgAAAAEAYgAAAAEAOAUAAAEAYgAAAAEA3QgAAAEAxwQAAAEAYgAAAAEAGwYAAAEAxwQAAAEAxwQAAAEABAcAAAIAFwkAAAMAVgkAAAEAFwkAAAIAfQYAAAEAxwQAAAEABAcAAAIAFwkAAAMAVgkAAAEAxwQAAAEAwwIAAAEAYgAAAAEAYgAAAAEAYgAAAAEAYgAAAAEAOAUAAAEAKgoAAAIAwwIAAAMA3QgAAAQAtQcAAAEAxwQAAAEAYgAAAAEAPQoCAEUABgAUAAgAEAAJAAwACQDDBwEAEQDDBwYAGQDDBwoAKQDDBxAAMQDDBxAAOQDDBxAAQQDDBxAASQDDBxAAUQDDBxAAWQDDBxAAYQDDBxUAaQDDBxAAcQDDBxAAeQDDBxAAkQDDBwYAoQDDBxoAAQFAByoAAQEjCTEACQHDBzYAuQDCCTwAuQCgCTwAgQDDBwYADADDBwYAGQEBAloAIQFLCl8AIQHbBWUA0QDDB2sAKQHdAXEAMQHoAgYAGQH6CHUAGQH5AXsAyQDDBwYAyQCpAIEAyQCeBYEAyQAfA4EAyQCJBYUAyQC6BoUAyQDHBo0AyQCDBQYAyQCwAJYAyQClBZ4AyQCUBY0AyQAmA6UAFABMCb0ASQEUAsEASQGPCcsASQE7CuYAHADDBzYASQGTAvcASQFuBuYAGQHzCBkBJAA/CiYBJAAqBiwBwQDUBgYAwQC5ADMB6QDrBzgBwQAyCkMBJAAzBkgBFAC1AFgBFADqCAEAFADDBwYA+QDkAHYBgQBwBXEAuQCUCXsBWQGYCIEBYQG1AIcBuQDOAo0BaQEYB5MBaQEjB2sAYQEqBp4BaQGDAnEAGQFgCqMBaQEmAxAAYQHNBBAAJADNBCYBIAB7ANQDIQB7ANQDIQCDANkDLgALAJYCLgATAJ8CLgAbAL4CLgAjAMcCLgArANUCLgAzAB4DLgA7ACQDLgBDAMcCLgBLADcDLgBTAB4DLgBbAB4DLgBjAE8DLgBrAHkDLgBzAIYDQAB7ANQDQQB7ANQDQQCDANkDYAB7ANQDYQB7ANQDYQCDANkDgAB7ANQDgQB7ANQDgQCDANkDoAB7ANQDoQB7ANQDoQCDANkDwAB7ANQDwQB7ANQDwQCDANkD4AB7ANQD4QB7ANQD4QCDANkDAQF7ANQDAQGDANkDIQF7ANQDIQGDANkDQQF7ANQDQQGDANkDQwF7ANQDYQF7ANQDYQGDANkDgQF7ANQDgQGDANkDoQF7ANQDoQGDANkDoAN7ANQDwAN7ANQD4AN7ANQDQAR7ANQDYAR7ANQD4AV7ANQDAAZ7ANQDQAZ7ANQD4Ad7ANQDAAh7ANQDIAh7ANQDQAh7ANQDYAh7ANQDIABLAIkAkgCtANwAEAE8AVABXgFnAXABmAECAAEABgAFAAcABwAIAA4ACQAPAAAAuAJfAgAApwdoAgAAcQdtAgAA0AhyAgAA0AhyAgAAPgl3AgAAYQZ7AgAArQB/AgAAogV/AgAAIwN/AgAAlwV7AgAAywZ7AgAADAaDAgAAuAKIAgAAIgqRAgAA0AhyAgAApwdoAgAAuAKIAgIAAQADAAIAAgAFAAEAAwAFAAIABAAHAAEABQAHAAIABgAJAAEABwAJAAIAHQALAAIAHgANAAEAHwANAAIAIgAPAAEAIwAPAAIAJAARAAIAJQATAAIAJgAVAAIAJwAXAAIAKAAZAAEAKQAZAAIALwAbAAEAMAAbAAIAMgAdAAIAPwAfAAIAQAAhAAIAQQAjAAIAQgAlAAEAQwAlAEMAtwDwAB8BBIAAAAEAAAAAAAAAAAAAAAAApAgAAAQAAAAAAAAAAAAAAKkBgQAAAAAABAAAAAAAAAAAAAAAsgF2AAAAAAAEAAAAAAAAAAAAAACpATwGAAAAAAQAAAAAAAAAAAAAAKkBmQIAAAAAAAAAAAEAAAC3BQAACgAIAF0A2ABjANgAAAAAAAA8PjlfXzdfMAA8R2V0TWluUmVzcG9uc2VTaXplPmJfXzdfMABJRW51bWVyYWJsZWAxAExpc3RgMQBGdW5jYDIASURpY3Rpb25hcnlgMgBJbnQ2NAA8PjkAPE1vZHVsZT4AcmVxdWVzdElEAFN5c3RlbS5JTwBTeXN0ZW0uV2ViAG1zY29ybGliADw+YwBTeXN0ZW0uQ29sbGVjdGlvbnMuR2VuZXJpYwBnZXRfQ2FuUmVhZABBZGQAZ2V0X0VsYXBzZWQAU3lzdGVtLkNvbGxlY3Rpb25zLlNwZWNpYWxpemVkAE5ld0d1aWQAPFN0YXRlU3RvcmU+a19fQmFja2luZ0ZpZWxkADxSZXNwb25zZVN0cmVhbT5rX19CYWNraW5nRmllbGQAPEJ5dGVzV3JpdHRlbj5rX19CYWNraW5nRmllbGQAPFJlcXVlc3RQcm9jZXNzb3I+a19fQmFja2luZ0ZpZWxkADxIdG1sR2VuZXJhdG9yPmtfX0JhY2tpbmdGaWVsZAA8TWVhc3VyZW1lbnRzPmtfX0JhY2tpbmdGaWVsZAA8V2lkZ2V0Q29udGVudD5rX19CYWNraW5nRmllbGQAPENvbnRleHQ+a19fQmFja2luZ0ZpZWxkAFJlYWRUb0VuZABQcm9jZXNzUmVxdWVzdEVuZABSZXBsYWNlAElzTnVsbE9yV2hpdGVTcGFjZQBBdmVyYWdlAEVudW1lcmFibGUASURpc3Bvc2FibGUARG91YmxlAElIdHRwTW9kdWxlAFN0YXRzTW9kdWxlAEdldE1vZHVsZVByb2Nlc3NpbmdUaW1lAEdldFJlcXVlc3RQcm9jZXNzaW5nVGltZQBnZXRfQ29udGVudFR5cGUAV2hlcmUAU3lzdGVtLkNvcmUAZ2V0X1N0YXRlU3RvcmUAc2V0X1N0YXRlU3RvcmUAc3RhdGVTdG9yZQBnZXRfUmVzcG9uc2UASHR0cFJlc3BvbnNlAERpc3Bvc2UARGVidWdnZXJCcm93c2FibGVTdGF0ZQBDbGVhbnVwQXBwbGljYXRpb25TdGF0ZQBnZXRfQ2FuV3JpdGUAQ29tcGlsZXJHZW5lcmF0ZWRBdHRyaWJ1dGUAR3VpZEF0dHJpYnV0ZQBEZWJ1Z2dhYmxlQXR0cmlidXRlAERlYnVnZ2VyQnJvd3NhYmxlQXR0cmlidXRlAENvbVZpc2libGVBdHRyaWJ1dGUAQXNzZW1ibHlUaXRsZUF0dHJpYnV0ZQBBc3NlbWJseVRyYWRlbWFya0F0dHJpYnV0ZQBUYXJnZXRGcmFtZXdvcmtBdHRyaWJ1dGUAQXNzZW1ibHlGaWxlVmVyc2lvbkF0dHJpYnV0ZQBBc3NlbWJseUNvbmZpZ3VyYXRpb25BdHRyaWJ1dGUAQXNzZW1ibHlEZXNjcmlwdGlvbkF0dHJpYnV0ZQBDb21waWxhdGlvblJlbGF4YXRpb25zQXR0cmlidXRlAEFzc2VtYmx5UHJvZHVjdEF0dHJpYnV0ZQBBc3NlbWJseUNvcHlyaWdodEF0dHJpYnV0ZQBBc3NlbWJseUNvbXBhbnlBdHRyaWJ1dGUAUnVudGltZUNvbXBhdGliaWxpdHlBdHRyaWJ1dGUAdmFsdWUAUmVtb3ZlAEdldEF2ZXJhZ2VSZXNwb25zZVNpemUATG9nUmVzcG9uc2VTaXplAEdldE1pblJlc3BvbnNlU2l6ZQBHZXRDdXJyZW50UmVzcG9uc2VTaXplAEdldE1heFJlc3BvbnNlU2l6ZQByZXNwb25zZVNpemUAU3lzdGVtLlRocmVhZGluZwBTeXN0ZW0uUnVudGltZS5WZXJzaW9uaW5nAFRvU3RyaW5nAFN0b3B3YXRjaABGbHVzaABnZXRfTGVuZ3RoAFNldExlbmd0aABnZXRfQ2FuU2VlawBXZWJTdGF0cy5kbGwAV2ViU3RhdHMuUmVzb3VyY2VzLlN0YXRzV2lkZ2V0Lmh0bWwAR2V0TWFuaWZlc3RSZXNvdXJjZVN0cmVhbQBnZXRfUmVzcG9uc2VTdHJlYW0Ac2V0X1Jlc3BvbnNlU3RyZWFtAHJlc3BvbnNlU3RyZWFtAGdldF9JdGVtAHNldF9JdGVtAFN5c3RlbQBUaW1lU3BhbgBnZXRfQnl0ZXNXcml0dGVuAHNldF9CeXRlc1dyaXR0ZW4ATWluAFNlZWtPcmlnaW4Ab3JpZ2luAEh0dHBBcHBsaWNhdGlvbgBTeXN0ZW0uUmVmbGVjdGlvbgBOYW1lVmFsdWVDb2xsZWN0aW9uAGdldF9Qb3NpdGlvbgBzZXRfUG9zaXRpb24AU3RvcABTeXN0ZW0uTGlucQBTdHJlYW1SZWFkZXIAVGV4dFJlYWRlcgBzZW5kZXIAYnVmZmVyAEV2ZW50SGFuZGxlcgBnZXRfRmlsdGVyAHNldF9GaWx0ZXIATWVhc3VyZW1lbnRGaWx0ZXIARW50ZXIASVJlcXVlc3RQcm9jZXNzb3IAZ2V0X1JlcXVlc3RQcm9jZXNzb3IAc2V0X1JlcXVlc3RQcm9jZXNzb3IASUh0bWxHZW5lcmF0b3IAZ2V0X0h0bWxHZW5lcmF0b3IAc2V0X0h0bWxHZW5lcmF0b3IAaHRtbEdlbmVyYXRvcgAuY3RvcgAuY2N0b3IATW9uaXRvcgBTeXN0ZW0uRGlhZ25vc3RpY3MAZ2V0X1RvdGFsTWlsbGlzZWNvbmRzAFdlYlN0YXRzLkludGVyZmFjZXMAU3lzdGVtLlJ1bnRpbWUuSW50ZXJvcFNlcnZpY2VzAFN5c3RlbS5SdW50aW1lLkNvbXBpbGVyU2VydmljZXMARGVidWdnaW5nTW9kZXMAQnVpbGREZXBlbmRlbmNpZXMARXZlbnRBcmdzAFdlYlN0YXRzLkltcGxlbWVudGF0aW9ucwBnZXRfSGVhZGVycwBXZWJTdGF0cwBJTWVhc3VyZW1lbnRzAGdldF9NZWFzdXJlbWVudHMAc2V0X01lYXN1cmVtZW50cwBtZWFzdXJlbWVudHMAUmVtb3ZlQXQAQ29uY2F0AEZvcm1hdABPYmplY3QAR2V0U3RhdHNXaWRnZXQAb2Zmc2V0AEluaXQARXhpdABnZXRfV2lkZ2V0Q29udGVudABzZXRfV2lkZ2V0Q29udGVudABnZXRfQ291bnQAY291bnQATG9nTW9kdWxlU3RhcnQATG9nUmVxdWVzdFN0YXJ0AFByb2Nlc3NSZXF1ZXN0U3RhcnQATGFzdABnZXRfUmVxdWVzdABhZGRfRW5kUmVxdWVzdABDb250ZXh0X0VuZFJlcXVlc3QAYWRkX0JlZ2luUmVxdWVzdABDb250ZXh0X0JlZ2luUmVxdWVzdABIdHRwUmVxdWVzdABUcmltUmVzcG9uc2VTaXplTGlzdABHZXRSZXNwb25zZVNpemVzTGlzdABnZXRfQ29udGV4dABjb250ZXh0AFN0YXJ0TmV3AE1heABDb250YWluc0tleQBHZXRFeGVjdXRpbmdBc3NlbWJseQBvcF9FcXVhbGl0eQAAR1cAZQBiAFMAdABhAHQAcwAuAFIAZQBzAG8AdQByAGMAZQBzAC4AUwB0AGEAdABzAFcAaQBkAGcAZQB0AC4AaAB0AG0AbAAAK3sAYwB1AHIAcgBlAG4AdABSAGUAcwBwAG8AbgBzAGUAUwBpAHoAZQB9AAANewAwADoAbgAwAH0AACN7AG0AaQBuAFIAZQBzAHAAbwBuAHMAZQBTAGkAegBlAH0AACt7AGEAdgBlAHIAYQBnAGUAUgBlAHMAcABvAG4AcwBlAFMAaQB6AGUAfQAAC3sAMAA6AG4AfQAAI3sAbQBhAHgAUgBlAHMAcABvAG4AcwBlAFMAaQB6AGUAfQAAGXsAbQBvAGQAdQBsAGUAVABpAG0AZQB9AAAbewByAGUAcQB1AGUAcwB0AFQAaQBtAGUAfQAAF00AbwBkAHUAbABlAFMAdABhAHIAdAAAE04AbwB0ACAARgBvAHUAbgBkAAANewAwADoAbgA0AH0AABlSAGUAcQB1AGUAcwB0AFMAdABhAHIAdAAAG1IAZQBzAHAAbwBuAHMAZQBTAGkAegBlAHMAACNXAGUAYgBTAHQAYQB0AHMAUgBlAHEAdQBlAHMAdABJAEQAABN0AGUAeAB0AC8AaAB0AG0AbAAAAAAASw6E9CO7iUKs/eE73AmPmAAEIAEBCAMgAAEFIAEBEREEIAEBDgQgAQECBSABARFNCQcCFRJVAg4cAgYAAgEcEAIEAAEBHAUgAgEcGAYgAQESgIUHFRKAiQIOHA4HCg0KDQoODgISZRJpDgQAAQIOBQAAEoCRBSABEmUOBSABARJlAyAADgUAAg4OHAUgAg4ODgMgAAIDIAAKAwcBCgQgAQEKAwcBCAcgAwgdBQgIBiACCgoRbQcgAwEdBQgICQcDFRJxAQoCDQUVEnEBCgMgAAgJAAENFRKAqQEKDBABAR4AFRKAqQEeAAMKAQoJBwMVEnEBCgIKCQABChUSgKkBCgYVEnkCCgIYEAECFRKAqQEeABUSgKkBHgAVEnkCHgACCAcEEmECDhF1BQACDg4OBhUSVQIOHAUgAQITAAYgARMBEwAEIAARdQMgAA0GBwISYRJhBAAAEmEHIAIBEwATAQcHARUScQEKBSABARMACAcCFRJxAQoCCAcCAhUScQEKBQcCDhF9BAAAEX0FIAASgK0FIAASgLEFIAIBDg4FIAASgLUEIAASZQUHAw4CDgQgAQ4OBQACAg4OCLd6XFYZNOCJCLA/X38R1Qo6BwYVElUCDhwDBhIUAwYSDAMGEhACBg4CBgoDBhJlAwYSXQMGEigHBhUSeQIKAggAABUSVQIOHAQgABIUBSABARIUBCAAEgwFIAEBEgwEIAASEAUgAQESEAYgAgEcElkFIAEBEl0DAAABBSABEmEOCSABARUSVQIOHAggABUSVQIOHAcgABUScQEKDyAEARJdFRJVAg4cEhASFAQgABJdBCABAgoICAAVElUCDhwEKAASFAQoABIMBCgAEhADKAAOAygACgMoAAIEKAASZQgoABUSVQIOHAQoABJdCAEACAAAAAAAHgEAAQBUAhZXcmFwTm9uRXhjZXB0aW9uVGhyb3dzAQgBAAcBAAAAAA0BAAhXZWJTdGF0cwAASAEAQ0FuIEh0dHBNb2R1bGUgdGhhdCBpbmplY3RzIHJlcXVlc3Qgc3RhdGlzdGljcyBpbnRvIHJlc3BvbnNlIGJvZGllcy4AAAUBAAAAABIBAA1KYXJlZCBHb29kd2luAAAXAQASQ29weXJpZ2h0IMKpICAyMDE5AAApAQAkOGVhMjEwMzItNjQ4Ni00NDBkLWFmMzAtYzdjNzBmZjFiZWNlAAAMAQAHMS4wLjAuMAAATQEAHC5ORVRGcmFtZXdvcmssVmVyc2lvbj12NC41LjIBAFQOFEZyYW1ld29ya0Rpc3BsYXlOYW1lFC5ORVQgRnJhbWV3b3JrIDQuNS4yBAEAAAAIAQAAAAAAAAAAAD4GAADvu788ZGl2IGNsYXNzPSd3aWRnZXQtd3JhcHBlcic+DQogICAgPGg0PldlYlN0YXRzPC9oND4NCiAgICA8ZGl2IGNsYXNzPSJzdGF0cy1mcmFtZSI+DQogICAgICAgIDxoNj48c3Ryb25nPlByb2Nlc3NpbmcgVGltZXM8L3N0cm9uZz48L2g2Pg0KICAgICAgICA8dWw+DQogICAgICAgICAgICA8bGk+DQogICAgICAgICAgICAgICAgUmVxdWVzdDogPHNwYW4gaWQ9InJlcXVlc3RUaW1lIj57cmVxdWVzdFRpbWV9PC9zcGFuPiBtcw0KICAgICAgICAgICAgPC9saT4NCiAgICAgICAgICAgIDxsaT4NCiAgICAgICAgICAgICAgICBNb2R1bGU6IDxzcGFuIGlkPSJtb2R1bGVUaW1lIj57bW9kdWxlVGltZX08L3NwYW4+IG1zDQogICAgICAgICAgICA8L2xpPg0KICAgICAgICA8L3VsPg0KICAgICAgICA8aDY+PHN0cm9uZz5SZXNwb25zZSBTaXplczwvc3Ryb25nPjwvaDY+DQogICAgICAgIDx1bD4NCiAgICAgICAgICAgIDxsaT4NCiAgICAgICAgICAgICAgICBDdXJyZW50OiA8c3BhbiBpZD0iY3VycmVudFJlc3BvbnNlU2l6ZSI+e2N1cnJlbnRSZXNwb25zZVNpemV9PC9zcGFuPiBieXRlcw0KICAgICAgICAgICAgPC9saT4NCiAgICAgICAgICAgIDxsaT4NCiAgICAgICAgICAgICAgICBTbWFsbGVzdDogPHNwYW4gaWQ9Im1pblJlc3BvbnNlU2l6ZSI+e21pblJlc3BvbnNlU2l6ZX08L3NwYW4+IGJ5dGVzDQogICAgICAgICAgICA8L2xpPg0KICAgICAgICAgICAgPGxpPg0KICAgICAgICAgICAgICAgIEF2ZXJhZ2U6IDxzcGFuIGlkPSJhdmVyYWdlcmVzcG9uc2VTaXplIj57YXZlcmFnZVJlc3BvbnNlU2l6ZX08L3NwYW4+IGJ5dGVzDQogICAgICAgICAgICA8L2xpPg0KICAgICAgICAgICAgPGxpPg0KICAgICAgICAgICAgICAgIExhcmdlc3Q6IDxzcGFuIGlkPSJtYXhSZXNwb25zZVNpemUiPnttYXhSZXNwb25zZVNpemV9PC9zcGFuPiBieXRlcw0KICAgICAgICAgICAgPC9saT4NCiAgICAgICAgPC91bD4NCiAgICA8L2Rpdj4NCjwvZGl2Pg0KDQo8c3R5bGU+DQogICAgLndpZGdldC13cmFwcGVyIHsNCiAgICAgICAgcG9zaXRpb246IGZpeGVkOw0KICAgICAgICByaWdodDogMTBweDsNCiAgICAgICAgYm90dG9tOiAxMHB4Ow0KICAgICAgICBiYWNrZ3JvdW5kOiB3aGl0ZXNtb2tlOw0KICAgICAgICBib3JkZXI6IDFweCBzb2xpZCBzdGVlbGJsdWU7DQogICAgICAgIHBhZGRpbmc6IDEwcHg7DQogICAgICAgIGJvcmRlci1yYWRpdXM6IDVweDsNCiAgICAgICAgdHJhbnNpdGlvbjogYWxsIC41cyBlYXNlOw0KICAgIH0NCg0KICAgIC5z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AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAwAAAD0PQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="
$ModuleBytes = [System.Convert]::FromBase64String($HttpModuleBase64)

# Determine if the script is running with elevated permissions (e.g. Run as Administrator).
function Is-Administrator() {
    $Identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $Principal = New-Object System.Security.Principal.WindowsPrincipal -ArgumentList $Identity
    return $Principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}


#region Startup checks

if ([System.Environment]::Is64BitProcess -eq $false){
    Write-Host "This script requires the 64-bit version of PowerShell.  Please relaunch in 64-bit."
    pause
    return
}

try {
    Get-Command -Name "Get-Website" | Out-Null
}
catch {
    Write-Host "It appears some required cmdlets are missing.  Please make sure the WebAdministration module is installed."
    pause
    return
}


if ((Is-Administrator) -eq $false) {
    # If current script file can't be determined, warn and exit.
    if ((Test-Path -Path $MyInvocation.InvocationName) -eq $false) {
        Write-Host "This install script must be run from an elevated console (e.g. Run as Administrator)."
        pause
        exit
    }

    # Else, attempt to self-elevate.
	Write-Host "Install script requires elevation (e.g. Run as Administrator).  Attempting to self-elevate..."
	Start-Sleep -Seconds 3
	$param = "-f `"$($MyInvocation.InvocationName)`""
	Start-Process -FilePath powershell.exe -ArgumentList "$param" -Verb RunAs
	exit
}

#endregion


# Add WebStats module to each IIS website.
[PSCustomObject[]]$Sites = Get-Website
foreach ($site in $Sites) {
    $existingModule = Get-WebConfiguration -PSPath "IIS:\Sites\$($site.name)" -Filter "/system.webServer/modules/add[@name='WebStats']"
    if ($existingModule -eq $null){
        Add-WebConfiguration -PSPath "IIS:\Sites\$($site.name)" -Filter "/system.webServer/modules" -Value @{name="WebStats"; type="WebStats.StatsModule"}
    }

    $modulePath = [System.Environment]::ExpandEnvironmentVariables($site.physicalPath + "\bin\WebStats.dll")
    [System.IO.File]::WriteAllBytes($modulePath, $ModuleBytes)
}

Write-Host "Installation complete." -ForegroundColor Green
pause
