namespace com.satinfotech.studentdb;
using {managed,cuid} from '@sap/cds/common';
@assert.unique:{
    st_id:[st_id]
}
//managed adds created on or updated on and created or updated By info of the record to db
entity Student : cuid, managed{
    @title:'Student ID'
    st_id:String(10);
    @title:'Gender'
    gender:String(1);
    @title:'First Name'
    first_name:String(10) @mandatory;
    @title:'Last Name'
    last_name:String(10);
    @title:'Email Address'
    email_id:String(40) @mandatory;
    @title:'PAN Number'
    pan_no:String(10);
    @title:'DOB'
    dob: Date ;
    @title:'Course selected'
    course:Association to Courses;
    Languages : Composition of many{
        key ID: UUID;
        lang :Association to Languages;

    }
    @title:'Age'
    virtual age:Integer @Core.Computed;
    @title:'is alumni'
    is_alumni:Boolean default false;
}

@cds.persistence.skip
entity Gender {
    @title:'code'
    key code: String(1);
    @title:'description'
    description:String(10);
    
}

entity Courses : cuid, managed {
    @title:'Code'
    code:String(5);
    @title:'Description'
    description:String(30);
     Books : Composition of many{
        key ID: UUID;
       book :Association to Books;
    }
}

entity Languages : cuid,managed{
    @title:'Code'
    code:String(3);
    @title:'Description'
    description:String(20);
}
entity Books : cuid,managed{
    @title:'Code'
    code:String(3);
    @title:'Description'
    description:String(20);
}