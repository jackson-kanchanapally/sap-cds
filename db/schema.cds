namespace com.satinfotech.studentdb;

entity Student{
    @title:'Student ID'
    key st_id:String(10);
    @title:'Gender'
    gender:String(1);
    @title:'First Name'
    first_name:String(10) @mandatory;
    @title:'Last Name'
    last_name:String(10) @mandatory;
    @title:'Email Address'
    email_id:String(40) @mandatory;
    @title:'PAN Number'
    pan_no:String(10);
    @title:'DOB'
    dob: Date @mandatory;
    @title:'Age'
    virtual age:Integer @Core.Computed;
    virtual Gen_Des: String @Core.Computed;

}

@cds.persistence.skip
entity Gender {
    @title:'code'
    key code: String(1);
    @title:'description'
    description:String(10);
}