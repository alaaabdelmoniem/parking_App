// {/* Navigation */}
//       <nav className="flex-1 px-3 py-4 space-y-1">
//         {navItems.map(item => {
//           const isActive = active === item.screen
//           return (
//             <button
//               key={item.screen}
//               onClick={() => onNavigate(item.screen)}
//               className="nav-item w-full flex items-center gap-3 px-3 py-2.5 rounded-xl text-left"
//               style={{
//                 backgroundColor: isActive ? 'rgba(37,99,235,0.2)' : 'transparent',
//                 color: isActive ? '#60A5FA' : 'rgba(255,255,255,0.55)',
//                 border: isActive ? '1px solid rgba(96,165,250,0.2)' : '1px solid transparent',
//                 position: 'relative',
//               }}
//             >
//               {item.icon(isActive)}
//               <span style={{ fontSize: 14, fontWeight: isActive ? 600 : 400 }}>{item.label}</span>
//               {item.screen === 'reservations' && hasActiveSession && (
//                 <span
//                   className="ml-auto flex items-center justify-center rounded-full"
//                   style={{ width: 18, height: 18, backgroundColor: '#16A34A', fontSize: 9, fontWeight: 700, color: 'white' }}
//                 >
//                   1
//                 </span>
//               )}
//             </button>
//           )
//         })}



// ReservationsScreenProps

//  active: { label: 'Active Now', bg: '#F0FDF4', color: '#16A34A', border: '#BBF7D0' },
//     upcoming: { label: 'Upcoming', bg: '#EFF6FF', color: '#2563EB', border: '#BFDBFE' },
//     completed: { label: 'Completed', bg: '#F8FAFC', color: '#64748B', border: '#E2E8F0' },
//     cancelled: { label: 'Cancelled', bg: '#FFF1F2', color: '#DC2626', border: '#FECDD3' },