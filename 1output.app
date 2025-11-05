import React, { useState, useEffect } from 'react';
import { Calendar, Clock, Image, BarChart3, Plus, Edit3, Trash2, Send, User, Settings, Bell, Search, Filter, Eye, Heart, MessageCircle, Share2, Palette, Type, Upload, CheckCircle, AlertCircle } from 'lucide-react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, PieChart, Pie, Cell, BarChart, Bar } from 'recharts';

const App = () => {
  const [activeTab, setActiveTab] = useState('dashboard');
  const [posts, setPosts] = useState([
    {
      id: 1,
      title: 'New Brand Identity Design',
      content: 'Excited to share our latest brand identity project for a tech startup. Clean, modern, and impactful!',
      image: 'https://placehold.co/600x400/4f46e5/ffffff?text=Brand+Identity',
      platform: 'Instagram',
      scheduledDate: '2023-12-15',
      scheduledTime: '14:30',
      status: 'scheduled',
      likes: 124,
      comments: 23,
      shares: 12,
      accountId: 'account1'
    },
    {
      id: 2,
      title: 'Typography Exploration',
      content: 'Playing with different typography combinations for client projects. Which one do you prefer?',
      image: 'https://placehold.co/600x400/ec4899/ffffff?text=Typography',
      platform: 'Twitter',
      scheduledDate: '2023-12-18',
      scheduledTime: '10:00',
      status: 'scheduled',
      likes: 89,
      comments: 15,
      shares: 8,
      accountId: 'account2'
    },
    {
      id: 3,
      title: 'Color Palette Inspiration',
      content: 'Inspired by nature today. These earthy tones are perfect for the upcoming fall collection.',
      image: 'https://placehold.co/600x400/10b981/ffffff?text=Color+Palette',
      platform: 'LinkedIn',
      scheduledDate: '2023-12-20',
      scheduledTime: '09:15',
      status: 'published',
      likes: 256,
      comments: 42,
      shares: 31,
      accountId: 'account1'
    }
  ]);

  const [accounts] = useState([
    { id: 'account1', name: 'Design Studio', platform: 'Instagram', connected: true },
    { id: 'account2', name: 'Creative Portfolio', platform: 'Twitter', connected: true },
    { id: 'account3', name: 'Professional Profile', platform: 'LinkedIn', connected: false }
  ]);

  const [analyticsData] = useState([
    { name: 'Mon', engagement: 4000, impressions: 2400 },
    { name: 'Tue', engagement: 3000, impressions: 1398 },
    { name: 'Wed', engagement: 2000, impressions: 9800 },
    { name: 'Thu', engagement: 2780, impressions: 3908 },
    { name: 'Fri', engagement: 1890, impressions: 4800 },
    { name: 'Sat', engagement: 2390, impressions: 3800 },
    { name: 'Sun', engagement: 3490, impressions: 4300 },
  ]);

  const [platformData] = useState([
    { name: 'Instagram', value: 45, color: '#E1306C' },
    { name: 'Twitter', value: 25, color: '#1DA1F2' },
    { name: 'LinkedIn', value: 20, color: '#0A66C2' },
    { name: 'Facebook', value: 10, color: '#4267B2' },
  ]);

  const [showPostModal, setShowPostModal] = useState(false);
  const [selectedPost, setSelectedPost] = useState(null);
  const [showAccountModal, setShowAccountModal] = useState(false);

  const handleCreatePost = () => {
    setSelectedPost(null);
    setShowPostModal(true);
  };

  const handleEditPost = (post) => {
    setSelectedPost(post);
    setShowPostModal(true);
  };

  const handleDeletePost = (postId) => {
    setPosts(posts.filter(post => post.id !== postId));
  };

  const PostModal = () => {
    const [formData, setFormData] = useState({
      title: selectedPost?.title || '',
      content: selectedPost?.content || '',
      image: selectedPost?.image || '',
      platform: selectedPost?.platform || 'Instagram',
      scheduledDate: selectedPost?.scheduledDate || '',
      scheduledTime: selectedPost?.scheduledTime || '',
      accountId: selectedPost?.accountId || 'account1'
    });

    const handleSubmit = (e) => {
      e.preventDefault();
      if (selectedPost) {
        setPosts(posts.map(post => 
          post.id === selectedPost.id 
            ? { ...post, ...formData }
            : post
        ));
      } else {
        const newPost = {
          id: posts.length + 1,
          ...formData,
          status: 'scheduled',
          likes: 0,
          comments: 0,
          shares: 0
        };
        setPosts([...posts, newPost]);
      }
      setShowPostModal(false);
    };

    return (
      <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
        <div className="bg-white rounded-xl p-6 w-full max-w-2xl max-h-screen overflow-y-auto">
          <div className="flex justify-between items-center mb-6">
            <h2 className="text-2xl font-bold text-gray-800">
              {selectedPost ? 'Edit Post' : 'Create New Post'}
            </h2>
            <button 
              onClick={() => setShowPostModal(false)}
              className="text-gray-500 hover:text-gray-700"
            >
              ✕
            </button>
          </div>
          
          <form onSubmit={handleSubmit} className="space-y-6">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">Title</label>
              <input
                type="text"
                value={formData.title}
                onChange={(e) => setFormData({...formData, title: e.target.value})}
                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                placeholder="Enter post title"
              />
            </div>
            
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">Content</label>
              <textarea
                value={formData.content}
                onChange={(e) => setFormData({...formData, content: e.target.value})}
                rows={4}
                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                placeholder="Write your post content..."
              />
            </div>
            
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">Image URL</label>
              <div className="flex space-x-4">
                <input
                  type="text"
                  value={formData.image}
                  onChange={(e) => setFormData({...formData, image: e.target.value})}
                  className="flex-1 px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                  placeholder="Enter image URL"
                />
                <button
                  type="button"
                  className="px-4 py-2 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200"
                >
                  <Upload size={20} />
                </button>
              </div>
            </div>
            
            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Account</label>
                <select
                  value={formData.accountId}
                  onChange={(e) => setFormData({...formData, accountId: e.target.value})}
                  className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                >
                  {accounts.map(account => (
                    <option key={account.id} value={account.id}>
                      {account.name} ({account.platform})
                    </option>
                  ))}
                </select>
              </div>
              
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Platform</label>
                <select
                  value={formData.platform}
                  onChange={(e) => setFormData({...formData, platform: e.target.value})}
                  className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                >
                  <option value="Instagram">Instagram</option>
                  <option value="Twitter">Twitter</option>
                  <option value="LinkedIn">LinkedIn</option>
                  <option value="Facebook">Facebook</option>
                </select>
              </div>
            </div>
            
            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Schedule Date</label>
                <input
                  type="date"
                  value={formData.scheduledDate}
                  onChange={(e) => setFormData({...formData, scheduledDate: e.target.value})}
                  className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                />
              </div>
              
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Schedule Time</label>
                <input
                  type="time"
                  value={formData.scheduledTime}
                  onChange={(e) => setFormData({...formData, scheduledTime: e.target.value})}
                  className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                />
              </div>
            </div>
            
            <div className="flex justify-end space-x-4 pt-4">
              <button
                type="button"
                onClick={() => setShowPostModal(false)}
                className="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 transition-colors"
              >
                Cancel
              </button>
              <button
                type="submit"
                className="px-6 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition-colors"
              >
                {selectedPost ? 'Update Post' : 'Create Post'}
              </button>
            </div>
          </form>
        </div>
      </div>
    );
  };

  const AccountModal = () => {
    const [newAccount, setNewAccount] = useState({
      name: '',
      platform: 'Instagram'
    });

    const handleAddAccount = () => {
      // In a real app, this would connect to the social media API
      alert(`Account "${newAccount.name}" for ${newAccount.platform} would be connected`);
      setShowAccountModal(false);
    };

    return (
      <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
        <div className="bg-white rounded-xl p-6 w-full max-w-md">
          <div className="flex justify-between items-center mb-6">
            <h2 className="text-2xl font-bold text-gray-800">Connect Account</h2>
            <button 
              onClick={() => setShowAccountModal(false)}
              className="text-gray-500 hover:text-gray-700"
            >
              ✕
            </button>
          </div>
          
          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">Account Name</label>
              <input
                type="text"
                value={newAccount.name}
                onChange={(e) => setNewAccount({...newAccount, name: e.target.value})}
                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                placeholder="e.g., My Design Studio"
              />
            </div>
            
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">Platform</label>
              <select
                value={newAccount.platform}
                onChange={(e) => setNewAccount({...newAccount, platform: e.target.value})}
                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
              >
                <option value="Instagram">Instagram</option>
                <option value="Twitter">Twitter</option>
                <option value="LinkedIn">LinkedIn</option>
                <option value="Facebook">Facebook</option>
              </select>
            </div>
            
            <div className="flex justify-end space-x-4 pt-4">
              <button
                type="button"
                onClick={() => setShowAccountModal(false)}
                className="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 transition-colors"
              >
                Cancel
              </button>
              <button
                onClick={handleAddAccount}
                className="px-6 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition-colors"
              >
                Connect Account
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  };

  const Sidebar = () => (
    <div className="w-64 bg-white shadow-lg h-full flex flex-col">
      <div className="p-6 border-b">
        <div className="flex items-center space-x-3">
          <div className="w-10 h-10 bg-indigo-600 rounded-lg flex items-center justify-center">
            <Palette className="text-white" size={20} />
          </div>
          <div>
            <h1 className="text-xl font-bold text-gray-800">DesignPost</h1>
            <p className="text-sm text-gray-500">Social Scheduler</p>
          </div>
        </div>
      </div>
      
      <nav className="flex-1 p-4">
        <ul className="space-y-2">
          {[
            { id: 'dashboard', label: 'Dashboard', icon: BarChart3 },
            { id: 'calendar', label: 'Calendar', icon: Calendar },
            { id: 'posts', label: 'Posts', icon: Image },
            { id: 'analytics', label: 'Analytics', icon: BarChart3 },
            { id: 'accounts', label: 'Accounts', icon: User }
          ].map((item) => (
            <li key={item.id}>
              <button
                onClick={() => setActiveTab(item.id)}
                className={`w-full flex items-center space-x-3 px-4 py-3 rounded-lg transition-colors ${
                  activeTab === item.id 
                    ? 'bg-indigo-50 text-indigo-600' 
                    : 'text-gray-600 hover:bg-gray-50'
                }`}
              >
                <item.icon size={20} />
                <span>{item.label}</span>
              </button>
            </li>
          ))}
        </ul>
      </nav>
      
      <div className="p-4 border-t">
        <div className="flex items-center space-x-3 p-3 bg-gray-50 rounded-lg">
          <div className="w-10 h-10 bg-indigo-100 rounded-full flex items-center justify-center">
            <User className="text-indigo-600" size={20} />
          </div>
          <div>
            <p className="font-medium text-gray-800">Alex Designer</p>
            <p className="text-sm text-gray-500">alex@example.com</p>
          </div>
        </div>
      </div>
    </div>
  );

  const Dashboard = () => (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="text-3xl font-bold text-gray-800">Dashboard</h1>
        <button 
          onClick={handleCreatePost}
          className="flex items-center space-x-2 bg-indigo-600 text-white px-4 py-2 rounded-lg hover:bg-indigo-700 transition-colors"
        >
          <Plus size={20} />
          <span>Create Post</span>
        </button>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <div className="bg-white p-6 rounded-xl shadow-sm border">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-gray-500 text-sm">Total Posts</p>
              <p className="text-2xl font-bold text-gray-800">{posts.length}</p>
            </div>
            <div className="w-12 h-12 bg-indigo-100 rounded-lg flex items-center justify-center">
              <Image className="text-indigo-600" size={24} />
            </div>
          </div>
        </div>
        
        <div className="bg-white p-6 rounded-xl shadow-sm border">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-gray-500 text-sm">Scheduled</p>
              <p className="text-2xl font-bold text-gray-800">
                {posts.filter(p => p.status === 'scheduled').length}
              </p>
            </div>
            <div className="w-12 h-12 bg-yellow-100 rounded-lg flex items-center justify-center">
              <Clock className="text-yellow-600" size={24} />
            </div>
          </div>
        </div>
        
        <div className="bg-white p-6 rounded-xl shadow-sm border">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-gray-500 text-sm">Published</p>
              <p className="text-2xl font-bold text-gray-800">
                {posts.filter(p => p.status === 'published').length}
              </p>
            </div>
            <div className="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
              <Send className="text-green-600" size={24} />
            </div>
          </div>
        </div>
        
        <div className="bg-white p-6 rounded-xl shadow-sm border">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-gray-500 text-sm">Engagement</p>
              <p className="text-2xl font-bold text-gray-800">
                {posts.reduce((sum, post) => sum + post.likes + post.comments + post.shares, 0)}
              </p>
            </div>
            <div className="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center">
              <Heart className="text-purple-600" size={24} />
            </div>
          </div>
        </div>
      </div>
      
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="bg-white p-6 rounded-xl shadow-sm border">
          <h3 className="text-lg font-semibold text-gray-800 mb-4">Engagement Overview</h3>
          <ResponsiveContainer width="100%" height={300}>
            <LineChart data={analyticsData}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="name" />
              <YAxis />
              <Tooltip />
              <Line type="monotone" dataKey="engagement" stroke="#4f46e5" strokeWidth={2} />
              <Line type="monotone" dataKey="impressions" stroke="#10b981" strokeWidth={2} />
            </LineChart>
          </ResponsiveContainer>
        </div>
        
        <div className="bg-white p-6 rounded-xl shadow-sm border">
          <h3 className="text-lg font-semibold text-gray-800 mb-4">Platform Distribution</h3>
          <ResponsiveContainer width="100%" height={300}>
            <PieChart>
              <Pie
                data={platformData}
                cx="50%"
                cy="50%"
                labelLine={false}
                outerRadius={80}
                fill="#8884d8"
                dataKey="value"
                label={({ name, percent }) => `${name} ${(percent * 100).toFixed(0)}%`}
              >
                {platformData.map((entry, index) => (
                  <Cell key={`cell-${index}`} fill={entry.color} />
                ))}
              </Pie>
              <Tooltip />
            </PieChart>
          </ResponsiveContainer>
        </div>
      </div>
    </div>
  );

  const Posts = () => (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="text-3xl font-bold text-gray-800">Scheduled Posts</h1>
        <button 
          onClick={handleCreatePost}
          className="flex items-center space-x-2 bg-indigo-600 text-white px-4 py-2 rounded-lg hover:bg-indigo-700 transition-colors"
        >
          <Plus size={20} />
          <span>New Post</span>
        </button>
      </div>
      
      <div className="bg-white rounded-xl shadow-sm border overflow-hidden">
        <div className="p-4 border-b">
          <div className="flex space-x-4">
            <div className="relative flex-1">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400" size={20} />
              <input
                type="text"
                placeholder="Search posts..."
                className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
              />
            </div>
            <button className="flex items-center space-x-2 px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50">
              <Filter size={20} />
              <span>Filter</span>
            </button>
          </div>
        </div>
        
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Post</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Account</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Platform</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Schedule</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Engagement</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
              </tr>
            </thead>
            <tbody className="bg-white divide-y divide-gray-200">
              {posts.map((post) => {
                const account = accounts.find(a => a.id === post.accountId);
                return (
                  <tr key={post.id} className="hover:bg-gray-50">
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="flex items-center">
                        <img className="h-12 w-12 object-cover rounded-lg" src={post.image} alt={post.title} />
                        <div className="ml-4">
                          <div className="text-sm font-medium text-gray-900">{post.title}</div>
                          <div className="text-sm text-gray-500 line-clamp-1">{post.content}</div>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="text-sm text-gray-900">{account?.name || 'Unknown'}</div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <span className={`px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${
                        post.platform === 'Instagram' ? 'bg-pink-100 text-pink-800' :
                        post.platform === 'Twitter' ? 'bg-blue-100 text-blue-800' :
                        post.platform === 'LinkedIn' ? 'bg-blue-50 text-blue-700' :
                        'bg-blue-100 text-blue-800'
                      }`}>
                        {post.platform}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="text-sm text-gray-900">{post.scheduledDate}</div>
                      <div className="text-sm text-gray-500">{post.scheduledTime}</div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <span className={`px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${
                        post.status === 'scheduled' ? 'bg-yellow-100 text-yellow-800' : 'bg-green-100 text-green-800'
                      }`}>
                        {post.status}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                      <div className="flex space-x-4">
                        <span className="flex items-center">
                          <Heart size={16} className="mr-1 text-red-500" />
                          {post.likes}
                        </span>
                        <span className="flex items-center">
                          <MessageCircle size={16} className="mr-1 text-blue-500" />
                          {post.comments}
                        </span>
                        <span className="flex items-center">
                          <Share2 size={16} className="mr-1 text-green-500" />
                          {post.shares}
                        </span>
                      </div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm font-medium">
                      <div className="flex space-x-2">
                        <button 
                          onClick={() => handleEditPost(post)}
                          className="text-indigo-600 hover:text-indigo-900"
                        >
                          <Edit3 size={16} />
                        </button>
                        <button 
                          onClick={() => handleDeletePost(post.id)}
                          className="text-red-600 hover:text-red-900"
                        >
                          <Trash2 size={16} />
                        </button>
                      </div>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );

  const CalendarView = () => (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="text-3xl font-bold text-gray-800">Calendar</h1>
        <button 
          onClick={handleCreatePost}
          className="flex items-center space-x-2 bg-indigo-600 text-white px-4 py-2 rounded-lg hover:bg-indigo-700 transition-colors"
        >
          <Plus size={20} />
          <span>New Post</span>
        </button>
      </div>
      
      <div className="bg-white rounded-xl shadow-sm border p-6">
        <div className="grid grid-cols-7 gap-4 mb-4">
          {['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map(day => (
            <div key={day} className="text-center font-medium text-gray-700 py-2">
              {day}
            </div>
          ))}
        </div>
        
        <div className="grid grid-cols-7 gap-4">
          {Array.from({ length: 35 }, (_, i) => {
            const day = i - 5;
            const isCurrentMonth = day > 0 && day <= 31;
            const date = isCurrentMonth ? `2023-12-${day < 10 ? '0' + day : day}` : '';
            const dayPosts = posts.filter(post => post.scheduledDate === date);
            
            return (
              <div 
                key={i} 
                className={`min-h-24 p-2 border rounded-lg ${
                  isCurrentMonth ? 'bg-white border-gray-200' : 'bg-gray-50 border-gray-100'
                }`}
              >
                {isCurrentMonth && (
                  <>
                    <div className="font-medium text-gray-800">{day}</div>
                    <div className="mt-1 space-y-1">
                      {dayPosts.map(post => (
                        <div 
                          key={post.id}
                          className={`text-xs p-1 rounded truncate ${
                            post.platform === 'Instagram' ? 'bg-pink-100 text-pink-800' :
                            post.platform === 'Twitter' ? 'bg-blue-100 text-blue-800' :
                            post.platform === 'LinkedIn' ? 'bg-blue-50 text-blue-700' :
                            'bg-blue-100 text-blue-800'
                          }`}
                        >
                          {post.title}
                        </div>
                      ))}
                    </div>
                  </>
                )}
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );

  const Analytics = () => (
    <div className="space-y-6">
      <h1 className="text-3xl font-bold text-gray-800">Analytics</h1>
      
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div className="bg-white p-6 rounded-xl shadow-sm border">
          <h3 className="text-lg font-semibold text-gray-800 mb-4">Total Engagement</h3>
          <div className="text-3xl font-bold text-indigo-600">
            {posts.reduce((sum, post) => sum + post.likes + post.comments + post.shares, 0)}
          </div>
          <p className="text-sm text-gray-500 mt-2">Across all platforms</p>
        </div>
        
        <div className="bg-white p-6 rounded-xl shadow-sm border">
          <h3 className="text-lg font-semibold text-gray-800 mb-4">Top Performing Post</h3>
          <div className="text-xl font-bold text-gray-800">
            {posts.reduce((max, post) => 
              (post.likes + post.comments + post.shares) > 
              (max.likes + max.comments + max.shares) ? post : max
            ).title}
          </div>
          <p className="text-sm text-gray-500 mt-2">Highest engagement post</p>
        </div>
        
        <div className="bg-white p-6 rounded-xl shadow-sm border">
          <h3 className="text-lg font-semibold text-gray-800 mb-4">Best Platform</h3>
          <div className="text-xl font-bold text-gray-800">
            {platformData.reduce((max, platform) => 
              platform.value > max.value ? platform : max
            ).name}
          </div>
          <p className="text-sm text-gray-500 mt-2">Highest engagement rate</p>
        </div>
      </div>
      
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="bg-white p-6 rounded-xl shadow-sm border">
          <h3 className="text-lg font-semibold text-gray-800 mb-4">Engagement Over Time</h3>
          <ResponsiveContainer width="100%" height={300}>
            <LineChart data={analyticsData}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="name" />
              <YAxis />
              <Tooltip />
              <Line type="monotone" dataKey="engagement" stroke="#4f46e5" strokeWidth={2} />
            </LineChart>
          </ResponsiveContainer>
        </div>
        
        <div className="bg-white p-6 rounded-xl shadow-sm border">
          <h3 className="text-lg font-semibold text-gray-800 mb-4">Platform Performance</h3>
          <ResponsiveContainer width="100%" height={300}>
            <PieChart>
              <Pie
                data={platformData}
                cx="50%"
                cy="50%"
                labelLine={false}
                outerRadius={80}
                fill="#8884d8"
                dataKey="value"
                label={({ name, percent }) => `${name} ${(percent * 100).toFixed(0)}%`}
              >
                {platformData.map((entry, index) => (
                  <Cell key={`cell-${index}`} fill={entry.color} />
                ))}
              </Pie>
              <Tooltip />
            </PieChart>
          </ResponsiveContainer>
        </div>
      </div>
      
      <div className="bg-white p-6 rounded-xl shadow-sm border">
        <h3 className="text-lg font-semibold text-gray-800 mb-4">Engagement by Platform</h3>
        <ResponsiveContainer width="100%" height={300}>
          <BarChart data={platformData}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="name" />
            <YAxis />
            <Tooltip />
            <Bar dataKey="value" fill="#4f46e5" />
          </BarChart>
        </ResponsiveContainer>
      </div>
    </div>
  );

  const Accounts = () => (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="text-3xl font-bold text-gray-800">Social Accounts</h1>
        <button 
          onClick={() => setShowAccountModal(true)}
          className="flex items-center space-x-2 bg-indigo-600 text-white px-4 py-2 rounded-lg hover:bg-indigo-700 transition-colors"
        >
          <Plus size={20} />
          <span>Connect Account</span>
        </button>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {accounts.map(account => (
          <div key={account.id} className="bg-white rounded-xl shadow-sm border p-6">
            <div className="flex items-center justify-between mb-4">
              <div className="flex items-center space-x-3">
                <div className={`w-3 h-3 rounded-full ${account.connected ? 'bg-green-500' : 'bg-red-500'}`}></div>
                <h3 className="text-lg font-semibold text-gray-800">{account.name}</h3>
              </div>
              <span className={`px-2 py-1 text-xs rounded-full ${
                account.platform === 'Instagram' ? 'bg-pink-100 text-pink-800' :
                account.platform === 'Twitter' ? 'bg-blue-100 text-blue-800' :
                account.platform === 'LinkedIn' ? 'bg-blue-50 text-blue-700' :
                'bg-blue-100 text-blue-800'
              }`}>
                {account.platform}
              </span>
            </div>
            
            <div className="flex items-center justify-between">
              <span className={`inline-flex items-center px-3 py-1 rounded-full text-sm font-medium ${
                account.connected 
                  ? 'bg-green-100 text-green-800' 
                  : 'bg-red-100 text-red-800'
              }`}>
                {account.connected ? (
                  <>
                    <CheckCircle size={16} className="mr-1" />
                    Connected
                  </>
                ) : (
                  <>
                    <AlertCircle size={16} className="mr-1" />
                    Disconnected
                  </>
                )}
              </span>
              
              <button className="text-indigo-600 hover:text-indigo-800 text-sm font-medium">
                {account.connected ? 'Manage' : 'Connect'}
              </button>
            </div>
          </div>
        ))}
      </div>
      
      <div className="bg-white rounded-xl shadow-sm border p-6">
        <h3 className="text-lg font-semibold text-gray-800 mb-4">Account Statistics</h3>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="text-center p-4 bg-gray-50 rounded-lg">
            <div className="text-2xl font-bold text-gray-800">3</div>
            <div className="text-sm text-gray-500">Total Accounts</div>
          </div>
          <div className="text-center p-4 bg-green-50 rounded-lg">
            <div className="text-2xl font-bold text-green-800">2</div>
            <div className="text-sm text-green-600">Connected</div>
          </div>
          <div className="text-center p-4 bg-red-50 rounded-lg">
            <div className="text-2xl font-bold text-red-800">1</div>
            <div className="text-sm text-red-600">Disconnected</div>
          </div>
        </div>
      </div>
    </div>
  );

  const renderContent = () => {
    switch (activeTab) {
      case 'dashboard': return <Dashboard />;
      case 'posts': return <Posts />;
      case 'calendar': return <CalendarView />;
      case 'analytics': return <Analytics />;
      case 'accounts': return <Accounts />;
      default: return <Dashboard />;
    }
  };

  return (
    <div className="flex h-screen bg-gray-50">
      <Sidebar />
      
      <div className="flex-1 overflow-auto">
        <header className="bg-white shadow-sm border-b px-6 py-4">
          <div className="flex justify-between items-center">
            <div className="flex items-center space-x-4">
              <h2 className="text-xl font-semibold text-gray-800 capitalize">
                {activeTab}
              </h2>
            </div>
            <div className="flex items-center space-x-4">
              <button className="p-2 text-gray-500 hover:text-gray-700 relative">
                <Bell size={20} />
                <span className="absolute top-0 right-0 w-2 h-2 bg-red-500 rounded-full"></span>
              </button>
              <div className="w-8 h-8 bg-indigo-100 rounded-full flex items-center justify-center">
                <User className="text-indigo-600" size={16} />
              </div>
            </div>
          </div>
        </header>
        
        <main className="p-6">
          {renderContent()}
        </main>
      </div>
      
      {showPostModal && <PostModal />}
      {showAccountModal && <AccountModal />}
    </div>
  );
};

export default App;