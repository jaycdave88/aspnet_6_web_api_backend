using src.Data.Collections;
using src.Models;
using Microsoft.AspNetCore.Mvc;
using MongoDB.Driver;

namespace Api.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class InfectedController : ControllerBase
    {
        src.Data.MongoDB _mongoDB;
        IMongoCollection<Infection> _infectionCollection;

        public InfectedController(src.Data.MongoDB mongoDB)
        {
            _mongoDB = mongoDB;
            _infectionCollection = _mongoDB.DB.GetCollection<Infection>(typeof(Infection).Name.ToLower());
        }

        [HttpPost]
        public ActionResult SaveInfected([FromBody] InfectionDTO dto)
        {
            var infected = new Infection(dto.Birthday, dto.Sex, dto.Latitude, dto.Longitude);

            _infectionCollection.InsertOne(infected);
            
            return StatusCode(201, "Sucessfully added infected");
        }

        [HttpGet]
        public ActionResult GetInfected()
        {
            var infectados = _infectionCollection.Find(Builders<Infection>.Filter.Empty).ToList();
            
            return Ok(infectados);
        }
    }
}
