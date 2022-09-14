using MongoDB.Driver.GeoJsonObjectModel;

namespace src.Data.Collections
{
    public class Infection
    {
        public Infection(DateTime birthday, string sex, double latitude, double longitude)
        {
            this.Birthday = birthday;
            this.Sex = sex;
            this.Location = new GeoJson2DGeographicCoordinates(longitude, latitude);
        }
        
        public DateTime Birthday { get; set; }
        public string Sex { get; set; }
        public GeoJson2DGeographicCoordinates Location { get; set; }
    }
}