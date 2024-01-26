using {com.satinfotech.studentdb as db} from '../db/schema';

service StudentDB {
    entity Student as projection on db.Student;
    entity Gender as projection on db.Gender;
    

}

annotate StudentDB.Student with @odata.draft.enabled;
//enables to create records from interface once this draft is enabled we will not be able to push using yarc if 
//done they will get placed in draft table not the original table here it only takes the student id to add data one 
//more annnotation is added at line no.55


annotate StudentDB.Student with {
    first_name      @assert.format: '^[a-zA-Z]{2,}$';
    last_name      @assert.format: '^[a-zA-Z]{2,}$';    
    email_id     @assert.format: '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    pan_no      @assert.format: '^[A-Z]{5}[0-9]{4}[A-Z]{1}$';
    //telephone @assert.format: '^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$';
}

annotate StudentDB.Gender with @(
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : code
        },
        {
            $Type : 'UI.DataField',
            Value : description
        },
    ],
    UI.SelectionFields: [ code,description],
);


annotate StudentDB.Student with @(
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : st_id
        },
        {
            $Type : 'UI.DataField',
            Label:'Gender',
            Value : gender
        },
        {
            $Type : 'UI.DataField',
            Value : first_name
        },
        {
            $Type : 'UI.DataField',
            Value : last_name
        },
        {
            $Type : 'UI.DataField',
            Value : email_id
        },
        {
            $Type : 'UI.DataField',
            Value : pan_no
        },
        {
            $Type : 'UI.DataField',
            Value : dob
        },
        {
            $Type : 'UI.DataField',
            Value : age
        },
        
    ],
    UI.SelectionFields: [ first_name , last_name, email_id,pan_no,dob,age],
);

annotate StudentDB.Student with @(
    UI.FieldGroup #StudentInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : st_id,
            },
            {
                $Type : 'UI.DataField',
                Label:'Gender',
                Value : gender,
            },
            {
                $Type : 'UI.DataField',
                Value : first_name,
            },
            {
                $Type : 'UI.DataField',
                Value : last_name,
            },
            {
                $Type : 'UI.DataField',
                Value : email_id,
            },
            {
                $Type : 'UI.DataField',
                Value : pan_no,
            },
            {
                $Type : 'UI.DataField',
                Value : dob,
            },
          
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'StudentInfoFacet',
            Label : 'Student Information',
            Target : '@UI.FieldGroup#StudentInformation',
        },
    ],
    
);
annotate StudentDB.Student with {
    gender @(
        Common.ValueListWithFixedValues:true,
        Common.ValueList: {
            Label :'Genders',
            CollectionPath:'Gender',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty:gender,
                    ValueListProperty:'code'
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty:'description'
                }

            ]
        }
    )
}