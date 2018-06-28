using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using System.Net.Http;
using System.Text;
using Microsoft.AspNetCore.Mvc;
using Frontend.Models;

namespace Frontend.Controllers
{
    public class HomeController : Controller
    {
        HttpClient _client = new HttpClient();

        public IActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public IActionResult Upload()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Upload(string data)
        {
            string url = "http://127.0.0.1:5000/api/values";
            string id = SendData(url, data).Result;

            return Ok(id);
        }

        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        private async Task<string> GetData(string id)
        {
            var response = await _client.GetAsync("http://127.0.0.1:5000/api/values/" + id);
            string data = await response.Content.ReadAsStringAsync();

            return data;
        }

        private async Task<string> SendData(string url, string data)
        {
            string result = null;

            FormUrlEncodedContent content = new FormUrlEncodedContent(new[]
            {
                new KeyValuePair<string, string>("value", data)
            });
            var response = await _client.PostAsync(url, content);
            response.EnsureSuccessStatusCode();
            result = await response.Content.ReadAsStringAsync();

            return result;
        }
    }
}
