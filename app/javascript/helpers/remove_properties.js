export default function(arrayOfObject, ...deletableKeys) {
  const newArrayOfObject = [];

  arrayOfObject.forEach((object) => {
    const newObject = Object.entries(object).reduce(
      (prev, [key, value]) => ({
        ...prev,
        ...(!deletableKeys.includes(key) && { [key]: value }),
      }),
      {}
    );

    newArrayOfObject.push(newObject);
  });

  return newArrayOfObject;
}
