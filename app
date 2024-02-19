import React, { useState } from 'react';

function App() {
  const [items, setItems] = useState([]);
  const [firstName, setFirstName] = useState('');
  const [lastName, setLastName] = useState('');
  const [jobType, setJobType] = useState('');
  const [editId, setEditId] = useState(null);
  const [editFirstName, setEditFirstName] = useState('');
  const [editLastName, setEditLastName] = useState('');
  const [editJobType, setEditJobType] = useState('');

  const addItem = () => {
    if (firstName.trim() !== '' && lastName.trim() !== '' && jobType.trim() !== '') {
      setItems([...items, { id: Date.now(), firstName, lastName, jobType }]);
      setFirstName('');
      setLastName('');
      setJobType('');
    }
  };

  const deleteItem = (id) => {
    setItems(items.filter(item => item.id !== id));
  };

  const updateItem = (id, newFirstName, newLastName, newJobType) => {
    const updatedItems = items.map(item => {
      if (item.id === id) {
        return { ...item, firstName: newFirstName, lastName: newLastName, jobType: newJobType };
      }
      return item;
    });
    setItems(updatedItems);
    setEditId(null);
    setEditFirstName('');
    setEditLastName('');
    setEditJobType('');
  };

  const handleEdit = (id, firstName, lastName, jobType) => {
    setEditId(id);
    setEditFirstName(firstName);
    setEditLastName(lastName);
    setEditJobType(jobType);
  };

  return (
    <div>
      <h2>CRUD App</h2>
      <div>
        <label htmlFor="firstName">First Name:</label>
        <input
          type="text"
          id="firstName"
          value={firstName}
          onChange={e => setFirstName(e.target.value)}
          placeholder="Enter first name"
        />
      </div>
      <div>
        <label htmlFor="lastName">Last Name:</label>
        <input
          type="text"
          id="lastName"
          value={lastName}
          onChange={e => setLastName(e.target.value)}
          placeholder="Enter last name"
        />
      </div>
      <div>
        <label htmlFor="jobType">Job Type:</label>
        <input
          type="text"
          id="jobType"
          value={jobType}
          onChange={e => setJobType(e.target.value)}
          placeholder="Enter job type"
        />
      </div>
      <button onClick={addItem}>Add</button>
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Job Type</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          {items.map(item => (
            <tr key={item.id}>
              <td>{item.id}</td>
              <td>
                {editId === item.id ? (
                  <input
                    type="text"
                    value={editFirstName}
                    onChange={e => setEditFirstName(e.target.value)}
                  />
                ) : (
                  item.firstName
                )}
              </td>
              <td>
                {editId === item.id ? (
                  <input
                    type="text"
                    value={editLastName}
                    onChange={e => setEditLastName(e.target.value)}
                  />
                ) : (
                  item.lastName
                )}
              </td>
              <td>
                {editId === item.id ? (
                  <input
                    type="text"
                    value={editJobType}
                    onChange={e => setEditJobType(e.target.value)}
                  />
                ) : (
                  item.jobType
                )}
              </td>
              <td>
                {editId === item.id ? (
                  <button onClick={() => updateItem(item.id, editFirstName, editLastName, editJobType)}>Save</button>
                ) : (
                  <>
                    <button onClick={() => handleEdit(item.id, item.firstName, item.lastName, item.jobType)}>Edit</button>
                    <button onClick={() => deleteItem(item.id)}>Delete</button>
                  </>
                )}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default App;
