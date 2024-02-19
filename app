import React, { useState } from 'react';

function App() {
  const [items, setItems] = useState([]);
  const [formData, setFormData] = useState({
    firstName: '',
    lastName: '',
    jobType: ''
  });
  const [editId, setEditId] = useState(null);
  const [error, setError] = useState('');

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const addItem = () => {
    const { firstName, lastName, jobType } = formData;
    if (firstName.trim() !== '' && lastName.trim() !== '' && jobType.trim() !== '') {
      setItems([...items, { id: Date.now(), ...formData }]);
      setFormData({ firstName: '', lastName: '', jobType: '' });
      setError('');
    } else {
      setError('All fields are required');
    }
  };

  const deleteItem = (id) => {
    setItems(items.filter(item => item.id !== id));
  };

  const updateItem = (id) => {
    const updatedItems = items.map(item => {
      if (item.id === id) {
        return { ...item, ...formData };
      }
      return item;
    });
    setItems(updatedItems);
    setEditId(null);
    setFormData({ firstName: '', lastName: '', jobType: '' });
  };

  const handleEdit = (id, firstName, lastName, jobType) => {
    setEditId(id);
    setFormData({ firstName, lastName, jobType });
  };

  return (
    <div>
      <h2>CRUD App</h2>
      <div>
        <label htmlFor="firstName">First Name:</label>
        <input
          type="text"
          id="firstName"
          name="firstName"
          value={formData.firstName}
          onChange={handleChange}
          placeholder="Enter first name"
        />
      </div>
      <div>
        <label htmlFor="lastName">Last Name:</label>
        <input
          type="text"
          id="lastName"
          name="lastName"
          value={formData.lastName}
          onChange={handleChange}
          placeholder="Enter last name"
        />
      </div>
      <div>
        <label htmlFor="jobType">Job Type:</label>
        <input
          type="text"
          id="jobType"
          name="jobType"
          value={formData.jobType}
          onChange={handleChange}
          placeholder="Enter job type"
        />
      </div>
      {error && <p style={{ color: 'red' }}>{error}</p>}
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
                    value={formData.firstName}
                    onChange={handleChange}
                    name="firstName"
                  />
                ) : (
                  item.firstName
                )}
              </td>
              <td>
                {editId === item.id ? (
                  <input
                    type="text"
                    value={formData.lastName}
                    onChange={handleChange}
                    name="lastName"
                  />
                ) : (
                  item.lastName
                )}
              </td>
              <td>
                {editId === item.id ? (
                  <input
                    type="text"
                    value={formData.jobType}
                    onChange={handleChange}
                    name="jobType"
                  />
                ) : (
                  item.jobType
                )}
              </td>
              <td>
                {editId === item.id ? (
                  <button onClick={() => updateItem(item.id)}>Save</button>
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
