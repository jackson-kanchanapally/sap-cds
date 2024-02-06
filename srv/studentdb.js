const cds = require('@sap/cds');

function calcAge(dob) {
    var today = new Date();
    var birthDate = new Date(Date.parse(dob));
    var age = today.getFullYear() - birthDate.getFullYear();
    var m = today.getMonth() - birthDate.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
        age--;
    }
    return age;
}

module.exports = cds.service.impl(async function () {
    const { Student,Gender,Courses } = this.entities;

    this.on('READ', Student, async (req) => {
        const results = await cds.run(req.query);
        if (Array.isArray(results)) {
            results.forEach(element => {
                element.age = calcAge(element.dob);
                if(element.gender=='F') element.gender="Female"
                if(element.gender=='M') element.gender="Male"
            });
        } else {
            results.age = calcAge(results.dob);
        }

        return results;
    });

    this.before('CREATE', Student, async (req) => {
        const age = calcAge(req.data.dob);
        if (age < 18 || age > 45) {
            req.error({ code: 'WRONGDOB', message: 'Student not the right age for school: ' + age, target: 'dob' });
        }
        const query1 = SELECT.from(Student).where({ email_id: req.data.email_id });
        const result = await cds.run(query1);
        if (result.length > 0) {
            req.error({ code: 'STEMAILEXISTS', message: 'Student with such email already exists', target: 'email_id' });
        }
    });
    this.before('CREATE', Courses, async (req) => {
        const query1 = SELECT.from(Courses).where({ ID: req.data.ID });
        const result = await cds.run(query1);
        if (result.length > 0) {
            req.error({ code: 'STEMAILEXISTS', message: 'Student with such email already exists', target: 'code' });
        }
        console.log(req.data.Books.book_ID)
    });

    this.before('UPDATE', Student, async (req) => {
        const { email_id, st_id } = req.data;
        if (email_id) {
            const query = SELECT.from(Student).where({ email_id: email_id }).and({ st_id: { '!=': st_id } });
            const result = await cds.run(query);
            if (result.length > 0) {
                req.error({ code: 'STEMAILEXISTS', message: 'Student with such email already exists', target: 'email_id' });
            }
        }
       
    });
    this.on('READ',Gender,async(req)=>{
        genders=[
            {"code":"M","description":"Male"},
            {"code":"F","description":"Female"}
        ]
        genders.$count=genders.length
        return genders;
    })
});
