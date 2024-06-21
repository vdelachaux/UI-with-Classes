# Description

The purpose of the `formMethod` method is :

* If it hasn't already been done, initialize the form controller class, and store its instance in the `Form.__DIALOG__` property.

* Call the `handleEvents()` function of the controller class, passing it the form event object. 

# How do I use it?

Starting with the `DEMO_1` example

## 1️⃣ Create a dialog controller class.

For a `formName` form, create a class named `_<formName>_Controller`.
 
![Explorer](./formMethod/explorer.png)

## 2️⃣ Use the method as the dialog's form method.

The `formMethod` method must be defined as the form method.

![Form](./formMethod/form.png)

## 3️⃣ Instantiate the form class in the dialog controller class.

In the dialog controller class constructor, the property `.form` is set as `cs.form.new(This)`.    
See the [example](#sample) below.

> ⚠️ If you use the UI classes from a component, the component will not be authorised to access the `form.4dform` file in your compiled and built project (i.e. in the .4DZ archive). So, to allow the component to access the form definition, you need to pass the contents of the form file as the second parameter:     

```4d
This.form:=cs.form.new(This; JSON Parse(File("/SOURCES/Forms/"+Current form name+"/form.4DForm").getText()))
```

## 4️⃣ Define the function handleEvents ( \$e ) In the dialog controller class.

The dialog class define, at least one function:  `.handleEvents()`    
See the [example](#sample) below.

## <a name="sample">Dialog controller class example</a>

```4d
// Class _myDialog_Controller
Class constructor
	
	This.form.init()
```