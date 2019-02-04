﻿using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using WebStats.Implementations;
using WebStats.Interfaces;

namespace WebStats
{
    public class StatsModule : IHttpModule
    {
        private static IDictionary<string, object> StateStore { get; } = new Dictionary<string, object>();
        private IHtmlGenerator HtmlGenerator { get; set; }
        private IRequestProcessor RequestProcessor { get; set; }

        private IMeasurements Measurements { get; set; }


        public void Context_BeginRequest(object sender, EventArgs e)
        {
            // Avoid race conditions.
            lock (StateStore)
            {
                BuildDependencies(sender as HttpApplication);
                RequestProcessor.ProcessRequestStart();
            }
        }

        private void BuildDependencies(HttpApplication context)
        {
            if (Measurements == null)
            {
                Measurements = new Measurements(StateStore);
            }
            if (HtmlGenerator == null)
            {
                HtmlGenerator = new HtmlGenerator(Measurements);
            }
            if (RequestProcessor == null)
            {
                RequestProcessor = new RequestProcessor(context, StateStore, Measurements, HtmlGenerator);
            }
        }

        public void Context_EndRequest(object sender, EventArgs e)
        {
            // Avoid race conditions.
            lock (StateStore)
            {
                RequestProcessor.ProcessRequestEnd();
            }
        }

        public void Dispose()
        {
            RequestProcessor = null;
            HtmlGenerator = null;
            Measurements = null;
        }

        public void Init(HttpApplication context)
        {
            context.BeginRequest += Context_BeginRequest;
            context.EndRequest += Context_EndRequest;
        }
    }
}