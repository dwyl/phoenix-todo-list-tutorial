var fs         = require('fs');
var path       = require('path');
var templatedir = __dirname +'/../email_templates/';
var htmlpath   = path.resolve(templatedir + 'welcome_html.html');
var textpath   = path.resolve(templatedir + 'welcome_text.txt');
var template   = fs.readFileSync(htmlpath, 'utf8')
var textonly   = fs.readFileSync(textpath, 'utf8')
// create reusable transporter object using SMTP transport
var mandrill    = require('mandrill-api');
var mandrill_client = new mandrill.Mandrill(process.env.MANDRILL_APIKEY);

module.exports = function email(person, callback) {
    var message = {
        "html": template,
        "text": textonly,
        "subject": "Welcome to DWYL",
        "from_email": "hello@dwyl.io",
        "from_name": "Hello from DWYL",
        "to": [{
                "email": person.email,
                // "name": "FirstName", // not using this for now.
                "type": "to"
            }],
        "headers": {
            "Reply-To": "hello@dwyl.io"
        },
        "important": false,
        "track_opens": true,
        "track_clicks": true,
        "tags": [
            "registration"
        ],
    };

    mandrill_client.messages.send({"message": message}, function(result) {
        // console.log(result);
        return callback(result);
    }, function(error) {
        // Mandrill returns the error as an object with name and message keys
        console.log('MANDRILL ERROR: ' + error.name + ' - ' + error.message);
        return callback(error);
        // A mandrill error occurred: Unknown_Subaccount - No subaccount exists with the id 'customer-123'
    });

}
